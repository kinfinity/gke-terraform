import json
import subprocess
import argparse

parser = argparse.ArgumentParser(
    description="Build and Push Lambda Images",
    formatter_class=argparse.ArgumentDefaultsHelpFormatter,
)
parser.add_argument(
    "--config", type=str, required=True, help="file path to pipeline configuration"
)
parser.add_argument(
    "--gitsha", type=str, required=True, help="git sha for the image tags"
)
parser.add_argument("--registry", type=str, required=True, help="ecr registry")
args = parser.parse_args()
config_args = vars(args)

print(config_args["config"])
config = json.load(open(config_args["config"]))

for service, service_vars in config["apps"].items():
    # build and push config image
    subprocess.check_call(
        [
            "ci/scripts/build-and-push-app.sh",
            config["docker_context_directory"],
            service_vars["service_name"],
            config["region"],
            config_args["registry"],
            str(config_args["gitsha"]),
            config["docker_file"]
        ]
    )
