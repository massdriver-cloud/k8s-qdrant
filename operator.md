## Kubernetes (K8s) Qdrant Service

Qdrant is a vector similarity search engine optimized for the cloud. It provides real-time search capabilities even for large datasets stored in a Kubernetes (K8s) cluster. The service enables users to handle search queries quickly and at scale by distributing workloads across different nodes in the cluster.

### Design Decisions

- **Helm Charts:** The module utilizes Helm charts to deploy the Qdrant service, ensuring a standardized and replicable installation process.
- **Dynamic Configuration:** The configuration values such as CPU, memory limits, and storage size are dynamically set based on the provided input variables.
- **Security:** An API key is automatically generated for secure access to the Qdrant service, and Kubernetes secrets are used to store sensitive data.
- **Alarms & Monitoring:** The module includes sub-modules for setting up monitoring and alarm channels to ensure high availability and reliability of the Qdrant service.
- **Namespace Isolation:** The Qdrant service is deployed into a specified namespace for better resource management and isolation.

### Runbook

#### Checking Qdrant Pod Status

If the Qdrant service is not reachable, you may want to check the status of the pods running in your Kubernetes cluster.

```sh
kubectl get pods -n <namespace> -l app.kubernetes.io/name=qdrant
```
Replace `<namespace>` with the specific namespace you have deployed Qdrant into.

Expected Result:
```sh
NAME                     READY   STATUS    RESTARTS   AGE
qdrant-<pod-id>          1/1     Running   0          5m
```
The pod should show a status of `Running`.

#### Viewing Qdrant Logs

If the pod status is not `Running`, you can check the logs of the Qdrant pod for any error messages.

```sh
kubectl logs -n <namespace> <pod-name>
```
Replace `<namespace>` with your namespace and `<pod-name>` with the specific pod ID.

#### Checking Kubernetes Events

Kubernetes events can provide insight into issues such as failed scheduling or insufficient resources.

```sh
kubectl get events -n <namespace>
```

#### Verifying API Key Authentication

To ensure that your API key is correctly set up and working, you can test it using curl.

```sh
API_KEY=$(kubectl get secret qdrant-api-key -o jsonpath="{.data.apiKey}" | base64 --decode)
curl -X POST "http://<qdrant-service>.<namespace>.svc.cluster.local:6333/collections" -H "Authorization: Bearer $API_KEY"
```

Expected Result:
```json
{
  "result": [],
  "status": "ok",
  "time": 0.001
}
```

#### Restarting Qdrant Pod

If you need to restart the Qdrant pod, you can delete it and let Kubernetes recreate it.

```sh
kubectl delete pod -n <namespace> <pod-name>
```

#### Connecting to Qdrant From Inside the Cluster

If you need to manually connect to the Qdrant service for debugging:

```sh
kubectl exec -it -n <namespace> <pod-name> -- /bin/bash
# Once inside the pod
curl -X GET "http://localhost:6333/health"
```

Expected Result:
```json
{
  "status": "ok"
}
```

This confirms that the Qdrant service is running correctly within the pod.

