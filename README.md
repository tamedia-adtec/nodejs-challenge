# Instructions for using this Platform NodeJS Repo Template for a NodeJS exposing an endpoint (e.g. API)

Use this template when creating a new NodeJS project that exposes an HTTP endpoint.

It provides basic files and configurations that will allow you to get up to speed when building a platform-deployable NodeJS application.

## 👀 This is not exactly what you need?

In case you need a different kind of application (e.g. static hosting, Cron-triggered application, etc.) and you can't find a template for it, please consider forking this repo.

## Setup Deployment Pipeline

### Step 1: Configure Project Files

Configure the following files.

Reference: [*TDA Dockerfile best practices*](https://github.com/tamedia-adtec/sre-wiki/tree/master/doc/k8s/docker#tda-dockerfile-best-practices).


> **TL;DR**
>
> In ***all files*** provided by this template, replace all of the following occurences as listed:
>  - `<APP_NAME>` => your app's repo name
>  - `<NAMESPACE>` => with a namespace for the Kubernetes location (so that it can be grouped with related applications)
>  - `<GROUP_ID>` => by the output of `python -c 'import random; print(random.randint(10000, 60000))'` (run it in the terminal)


#### Configure [`Dockerfile`](Dockerfile)

1. Replace `<GROUP_ID>`:
	1. Generate a random group id by running `python -c 'import random; print(random.randint(10000, 60000))'` in the terminal
	2. Copy the generated id and replace `<GROUP_ID>` with it.
2. Replace `<APP_NAME>` with your app name

#### Configure [`tdaci.env`](tdaci.env)

In `tdaci.env`:
```bash
export TDACI_NAMESPACE=default				# Enviroment used, default will use python3
export MY_SERVICE_VERSION=0.0.1 			# Version of the application
export MY_RELEASE_BRANCH=release			# (Leave as is)
export MY_SERVICE_NAME=gb-services/<APP_NAME>		# Service name
export MY_K8S_NAMESPACE=<NAMESPACE>			# Kubernetes namespace where the service is located
export MY_K8S_DIR=<APP_NAME>				# Directory where the service is located inside namespace
```

Replace every occurence of `<APP_NAME>` and `<NAMESPACE>` with the app name and the namespace you want it to be listed in, respectively.

### Step 2: Request a "CICD New Pipeline" @ #gb_ops_zähler on Slack

1. Go to the #gb_ops_zähler channel on Slack
2. Use the channel workflow shortcut to make a request for a new "CICD New Pipeline"
	![workflow- shortcut](https://user-images.githubusercontent.com/2809197/210779726-a86d2a77-3349-43c0-9763-fcd8c6f5de0b.png)
	1. Provide link to the repo
	2. Choose "GB" as the _K8S Cluster group_
	3. _Add to: "GOCD (Build) and ARGOCD (Deploy)"_ for the full build and deployment pipeline
	4. Under _Additional information_ add details about the application's context, technical and access requirements, interactions with API, etc. will help the @ops team follow-up on specifics and eventual manual configurations.

	![example-form](https://user-images.githubusercontent.com/2809197/210826500-a5cfde29-02ee-4ef1-a430-5268a049fc49.png)
3. Submit request
4. Prepare the *secrets* (e.g. AWS user credentials). You'll have to share them with the prompting member of the @ops team. **Important: remember to delete secret-related messages on slack once they have been received by the other party.**

### Step 3: Test the pipeline

When set up properly, the pipeline should be triggered when pushing commits to the `develop` branch. (Production branch solution name not known at the moment of writing this.)

Once the deployment pipeline works properly, you may delete this whole section (*Setup Deployment Pipeline*).

## Run and develop locally

```bash
npm run dev
```

### Test in Docker

Test your application works within Docker before pushing your commits to the CI/CD pipeline:

1. Make sure you have docker installed and running on your machine: https://docs.docker.com/get-docker/
2. Add `.env` file with following content:
	```
	PORT=3000
	```
	**Important note:** make sure environment variable files are always ignored by git.
3. Run docker using the `docker-compose.yml` configuration:
   ```bash
   docker compose up
   ```
4. The endpoint should now be available at https://localhost:3000/

**Important note on updating/changing source code locally:** the following sequence of commands will build a docker image and run it. Make sure you understand, that changes in the code have to be rebuilt and run again. Existing images will have to be teared down (`docker compose down`) to make place for your changes. We reccomend using the Docker desktop dashboard application to get an overview of instances available/running on your machine.
