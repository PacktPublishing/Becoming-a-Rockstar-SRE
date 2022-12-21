


kubectl apply -f https://litmuschaos.github.io/litmus/litmus-operator-v2.14.0.yaml

k apply -f web-chaos-sa.yaml
serviceaccount/web-chaos-sa created
role.rbac.authorization.k8s.io/web-chaos-sa created
rolebinding.rbac.authorization.k8s.io/web-chaos-sa created

kubectl apply -f https://hub.litmuschaos.io/api/chaos/2.14.0?file=charts/generic/pod-delete/experiment.yaml
chaosexperiment.litmuschaos.io/pod-delete created

k apply -f node/
deployment.apps/web-app created
service/web-app-lb created
service/web-app-svc created

k apply -f web-pod-delete.yaml 
chaosengine.litmuschaos.io/web-chaos created

k get pods
NAME                       READY   STATUS      RESTARTS   AGE
pod-delete-05thh2-rl7g5    0/1     Completed   0          37s
web-app-6bd549dfb5-bjt6b   1/1     Running     0          4m21s
web-app-6bd549dfb5-c8frt   1/1     Running     0          4m21s
web-app-6bd549dfb5-j94kv   1/1     Running     0          4m21s
web-chaos-runner           1/1     Running     0          44s

kubectl annotate deploy/web-app litmuschaos.io/chaos="true"

kubectl describe chaosresult web-chaos-pod-delete

kubectl patch service web-app-lb -p '{"spec":{"selector":{"app": "web-app"}}}'