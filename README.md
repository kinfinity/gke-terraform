# GKE Terraform

<table><tbody><tr><td><a href="https://github.com/kinfinity/gke-terraform/actions/workflows/infra-release.yaml"><img src="https://github.com/kinfinity/gke-terraform/actions/workflows/infra-release.yaml/badge.svg" alt="Infra Release"></a></td><td><a href="https://github.com/kinfinity/gke-terraform/actions/workflows/buildandpush-app.yaml"><img src="https://github.com/kinfinity/gke-terraform/actions/workflows/buildandpush-app.yaml/badge.svg" alt="Build &amp; Push"></a></td><td><a href="https://github.com/kinfinity/gke-terraform/actions/workflows/k8s-apps-release.yaml"><img src="https://github.com/kinfinity/gke-terraform/actions/workflows/k8s-apps-release.yaml/badge.svg" alt="K8s Deploy Apps"></a></td></tr></tbody></table>

This project aims to deploy a Kubernetes cluster on Google Cloud Platform (GCP) using Terraform. The infrastructure will include a load balancer for ingress, instances, and instance groups. Additionally, it will showcase the integration of a basic Next.js application, containerized with a small program rendering the Cohere logo on page load.

**Requirements**

<table><tbody><tr><td><code><strong>TOOL &nbsp;&nbsp;</strong></code></td><td><code><strong>VERSION &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</strong></code></td></tr><tr><td><code>Terraform&nbsp;</code></td><td><code>v1.7.4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</code></td></tr><tr><td><code>Python&nbsp;</code></td><td><code>3.12.2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</code></td></tr><tr><td><code>GCloud &nbsp;&nbsp;</code></td><td><code>Google Cloud SDK 466.0.0&nbsp;</code></td></tr><tr><td><code>Node &nbsp;&nbsp;</code></td><td><code>v20.11.1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</code></td></tr></tbody></table>

## Project Structure

```
.
├── terraform/
│   ├── environments
│   |   └── dev
│   |       ├── main.tf
│   |       ├── provider.tf
│   |       ├── variables.tf
│   |       ├── state.tf
│   |       └── versions.tf
│   └── modules
│       ├── compute
│       └── network
├─ k8s
│   ├── charts
|   |   └── cohere-app
│   └── manifests
│       └── postgress.yaml
├── ci/
│   ├── configs
│   └── scripts
├── app/
│   ├── Dockerfile
│   └── cohere-app
│       ├── package.json
│       ├── package-lock.json
│       └── ...
├── README.md
└── ...
```

### **Build & Push**

```
$ chmod +x ci/scripts/build-and-push-app.sh
$ python3 ci/scripts/build-and-push-all.py  --config ci/configs/pipeline-config.json --gitsha [GIT SHA] --registry gcr.io/[PROJECT_ID]
```

## **Run App**

The App is a simple nextjs app for k8s cluster access testing purposes.

- npm install

### **Build**

This command builds the app for production

```
$ npm run build
```

### **Start**

This command launches app with build configuration and files

```
$ npm run dev # runs in development mode and does not require pre-build
$ npm run start
```

## **Infrastructure as Code**

IaC is setup with Terraform. resouce modules are build in the `terraform/modules` directory and consumed when building each sub environment in `environment/[env]`

### **Plan**

```
$ python3 ci/scripts/execute-terraform.py --command plan --config ci/configs/pipeline-config.json --env dev
```

### **Apply**

```
$ python3 ci/scripts/execute-terraform.py --command apply --config ci/configs/pipeline-config.json --env dev
```
