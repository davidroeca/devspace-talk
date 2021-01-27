USER_ID = $(shell id -u)

.PHONY: setup
setup: start-minikube run-init-migrations

.PHONY: start-minikube
start-minikube:
	minikube start

.PHONY: run
run:
	devspace use namespace devspace-talk
	USER_ID=$(USER_ID) devspace dev --kube-context=minikube


.PHONY: get-names
get-names:
	./scripts/get-names

.PHONY: post-name
post-name:
	@if [ -z "$(NAME)" ]; then \
		echo "NAME must be an environment variable set for this command to work"; \
		exit 1; \
		fi
	./scripts/post-name $(NAME)

.PHONY: run-init-migrations
run-init-migrations:
	devspace use namespace devspace-talk
	USER_ID=$(USER_ID) devspace dev --exit-after-deploy
	sleep 10
	devspace enter --wait --image devspace-talk-backend-image -- \
		poetry run flask db upgrade

.PHONY: run-migrations
run-migrations:
	devspace use namespace devspace-talk
	devspace enter --wait --image devspace-talk-backend-image -- \
		poetry run flask db upgrade

.PHONY: generate-migration
generate-migration:
	@if [ -z "$(MESSAGE)" ]; then \
		echo "MESSAGE must be an environment variable set for this command to work"; \
		exit 1; \
		fi
	devspace use namespace devspace-talk
	devspace enter --wait --image devspace-talk-backend-image -- \
		poetry run flask db migrate -m "$(MESSAGE)"

.PHONY: stop-minikube
stop-minikube:
	minikube stop

.PHONY: delete-devspace
delete-devspace:
	# https://github.com/devspace-cloud/devspace/issues/941#issuecomment-586159182
	-rm -rf .devspace
	-devspace cleanup images
	-devspace purge

.PHONY: clean-minikube
clean-minikube:
	-minikube stop
	-minikube delete

.PHONY: clean
clean: delete-devspace clean-minikube # Clean up everything
	echo "Done."
