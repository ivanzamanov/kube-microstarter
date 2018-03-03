# kube-microstarter
A Java microservice starter project, targeted at Kubernetes as a dev accelerator. Uses [minikube](https://github.com/kubernetes/minikube) as the docker engine and Kubernetes cluster, so no need to install/pollute docker on the host.

# Prerequisites
JDK 8, Maven, bash.

# Setup
Run:
```
source ./prepare-env.sh
```
which will set up [minikube](https://github.com/kubernetes/minikube) and [kubectl](https://github.com/kubernetes/kubernetes) and point the docker client to it for building.
The tools will be downloaded to the local `tools/` folder.

# Building And Running
Builds a Spring Boot application, as well as a minimal docker image with it. The docker build is driven using Fabric8's [docker-maven-plugin](https://github.com/fabric8io/docker-maven-plugin) in Dockerfile mode.
Also generates Deployment, Service and Ingress objects under [microstarter/target/classes/continuous.yaml](microstarter/src/main/kube/continuous.yaml).
Docker image is tagged with `latest` by default, so we'll need to remove existing containers before building.
```
kubectl delete -f microstarter/target/classes/continuous.yaml
mvn package
kubectl apply -f microstarter/target/classes/continuous.yaml
```

In CI builds, one should generally override the tag and pull policy.
```
mvn deploy -Ddocker.image.tag=<branch-name>
```

For a continuous deployment pipeline, one can merely do:
```
mvn deploy -Ddocker.image.tag=<branch-name> -Dimage.pull.policy=Always
# Note that it's expected that kubectl is properly configured to point to an existing cluster
kubectl delete -f microstarter/target/classes/continuous.yaml
kubectl apply -f microstarter/target/classes/continuous.yaml
```
