USER_ID = $(shell id -u)

.PHONY: setup
setup: start-minikube run-migrations

.PHONY: start-minikube
start-minikube:
	minikube start

.PHONY: run
run:
	devspace use namespace devspace-talk
	USER_ID=$(USER_ID) devspace dev

.PHONY: run-migrations
run-migrations:
	echo "TODO: Run migrations"

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
