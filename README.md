# Devspace talk

This repo provides an example use case of devspace, for the purposes of a talk.

It is currently tested on Linux Mint, but should likely be simple to port to other operating systems.

## Prerequisites

- Install [Docker](https://www.docker.com/get-started) (version tested: `Docker version 20.10.2, build 2291f61`)
- Install [minikube](https://minikube.sigs.k8s.io/docs/) `1.16.0+`
- Install [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) `1.20.2+`
- Install [devspace](https://devspace.sh/) `5.7.3+`
  - Requires [Node.js](https://nodejs.org/en/)

## Running instructions

Once the prerequisites are installed, run the following commands:

```shell
# Necessary environment setup, including database migrations
make setup
# Run the application
make run
```

Then in another shell, we can test the API:

```shell
# See an empty response
make get-names
# Create the first name
NAME=my-first-name make post-name
# Check to see if that name was created
make get-names
```

## Change the data model, run database migration

1. Uncomment the code in related to `created` and `updated` in [backend/app/__init__.py](./backend/app/__init__.py) and [backend/app/models.py](./backend/app/models.py)
2. Auto-generate a migration: `MESSAGE="add created and updated" make generate-migration`
3. Inspect the auto-generated files within [backend/migrations/versions](./backend/migrations/versions), and edit them however you see fit.
4. Run the migrations

## For simpler onboarding

Check out the devspace ui:

```shell
devspace ui
```
