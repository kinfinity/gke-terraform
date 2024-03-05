#!/bin/bash

set -eu

# need to pass in environments
USAGE="USAGE:
${0} <terraform-multienv-root> <terraform-command[plan|apply]> <environment> <workspace>"

if [[ $# < 4 ]]; then
    echo "${USAGE}" >&2
    exit 1
fi

TERRAFORM_DIRECTORY=$1
TERRAFORM_CMD=$2
ENV_NAME=$3
WORKSPACE=$4

# Get absolute path of terraform environment
ENV_DIR="$(cd "${TERRAFORM_DIRECTORY}/environments/${ENV_NAME}/"; pwd -P)"
pushd ${ENV_DIR} > /dev/null

#  terraform init
terraform init
terraform validate
terraform workspace list
terraform workspace select $WORKSPACE

echo "configured workspace: ${ENV_NAME}/${WORKSPACE}"
ls
#  Run the provided command (e.g., plan or apply) with .tfvars
if [[ $TERRAFORM_CMD == *"plan"* ]]; then
    terraform $TERRAFORM_CMD -var-file=variables.tfvars
else
    terraform $TERRAFORM_CMD -var-file=variables.tfvars -auto-approve
fi

popd > /dev/null
