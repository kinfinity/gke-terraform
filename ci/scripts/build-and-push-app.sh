#!/bin/bash

set -eu

USAGE="USAGE:
${0} <app-directory> <app-name> <gcr-region> <gcr-registry>  <base-image-tag> <dockerfile>"

if [[ $# -ne 6 ]]; then
    echo "${USAGE}" >&2
    exit 1
fi

# Prepare vars
APP_NAME="${2}"
REGION="${3}"
REGISTRY="${4}"
IMAGE_TAG="${5}"
DOCKERFILE="${6}"

# Get absolute path of docker files dir
APP_DIR="$(cd "${1}"; pwd -P)"
pushd ${APP_DIR} > /dev/null


# clean_up func
clean_up() {
    [ -f  Dockerfile ]  && rm -f Dockerfile
    popd > /dev/null
}
# trap 'clean_up' EXIT SIGTERM ERR


# Authenticate Docker to GCR
gcloud auth configure-docker

# Check if the repository exists else create
repository_exists=$(gcloud container images list-tags gcr.io/${PROJECT_ID}/${APP_NAME} --format="value(digest)" 2>&1 || echo "")

if [ -z "$repository_exists" ]; then
    gcloud container images create gcr.io/${PROJECT_ID}/${APP_NAME}
fi

# BUILD IMAGE  & PUSH
echo Docker Build and Push
PUSH_TAG=$REGISTRY/${APP_NAME}:"v1"
echo $PUSH_TAG

# Build and Push
docker build --build-arg APP_NAME=${APP_NAME} -t ${APP_NAME}${IMAGE_TAG} -t $PUSH_TAG --no-cache=true -f $DOCKERFILE .
docker push $PUSH_TAG
