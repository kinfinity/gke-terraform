import json
import subprocess
import argparse

parser = argparse.ArgumentParser(
    description="Run terraform command across environments",
    formatter_class=argparse.ArgumentDefaultsHelpFormatter,
)
parser.add_argument("--command", type=str, required=True, help="plan | apply | destroy")
parser.add_argument(
    "--config",
    type=str,
    required=True,
    help="file path to pipeline configuration",
)
parser.add_argument("--env", type=str, required=True, help="")

args = parser.parse_args()
config_args = vars(args)

config = json.load(open(config_args["config"]))

for environment, environment_vars in config["environments"].items():
    for workspace in config["environments"][environment]["workspaces"]:
        # terraform run
        if environment == config_args["env"]:
            subprocess.check_call(
                [
                    "bash",
                    "ci/scripts/cmd-terraform-generic.sh",
                    config["terraform_directory"],
                    config_args["command"],  # command
                    environment,
                    workspace,  # workspace
                ]
            )
