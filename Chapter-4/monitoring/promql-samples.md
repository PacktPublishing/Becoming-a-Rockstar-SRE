# PromQL

## Overview

_Prometheus provides a functional query language called PromQL (Prometheus Query Language) that lets the user select and aggregate time series data in real time. The result of an expression can either be shown as a graph, viewed as tabular data in Prometheus's expression browser, or consumed by external systems via the HTTP API._

* More [info](https://prometheus.io/docs/prometheus/latest/querying/basics/)

## Examples

### Containers / Pod

* Per-pod sum of CPU usage in seconds (`container_name` only works for Docker runtime engine)
```
sum by (pod_name) (
  rate(container_cpu_usage_seconds_total{container_name!="POD"}[5m])
)
```

* Per-pod memory usage in Megabytes
```
container_memory_usage_bytes{namespace="default",image!="k8s.gcr.io/pause:3.5",name!=""} / (1024*1024)
```

* Per-pod CPU usage in percentage (the query doesn't return CPU usage for pods without CPU limits)

```
100 * max(
  rate(container_cpu_usage_seconds_total[5m])
    / on (container, pod)
  kube_pod_container_resource_limits{resource="cpu"}
) by (pod)
```

### Blackbox exporter

* Average duration times per instance

```
avg(probe_duration_seconds) by (instance)
```

* 90th quantile for the HTTP resolve time in ms for a certain instance

```
quantile_over_time(
  0.90,
  probe_http_duration_seconds{instance="http://35.198.13.1:60000/fortune",phase="resolve"}[28d]
)
```

## References

* Awesome blog [post](https://blog.freshtracks.io/a-deep-dive-into-kubernetes-metrics-b190cc97f0f6)
