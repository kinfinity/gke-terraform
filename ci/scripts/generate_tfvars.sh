#!/bin/bash

set -eu

# TODO: should be able to parse the json into terraform map
USAGE="USAGE:
${0} <terraform-env-directory> <project-id> <env-name>"

if [[ $# -ne 3 ]]; then
    echo "${USAGE}" >&2
    exit 1
fi

# Get absolute path of terraform dir
TERRAFORM_ENV_DIR="$(cd "${1}"; pwd -P)"

pushd ${TERRAFORM_ENV_DIR} > /dev/null

cat > variables.tfvars << EOF
    main_region                 =   "us-central1"
    gke_name                    =   "cohere-main-gke"
    gke_node_count              =   2
    project_id                  =   "${2}"
    env_name                    =   "${3}"
    network                     =   "default"
    subnetwork                  =   "default"
EOF
