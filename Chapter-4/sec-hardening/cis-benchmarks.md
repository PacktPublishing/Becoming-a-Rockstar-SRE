# CIS Benchmarks

## Overview

Center for Internet Security (CIS) Benchmarks are equivalent to our ITSO Tech Specs, but they are open, community-drive, and not owned by a specific company.

_With our global community of cybersecurity experts, we’ve developed CIS Benchmarks: more than 100 configuration guidelines across 25+ vendor product families to safeguard systems against today’s evolving cyber threats._


* CIS web [page](https://www.cisecurity.org/cis-benchmarks/)

## K8s CIS Benchmark

An objective, consensus-driven security guideline for the Kubernetes Server Software.

* CIS web [page](https://www.cisecurity.org/benchmark/kubernetes)

* Available Automation: [kube-bench](https://github.com/aquasecurity/kube-bench)

* Running on master: `docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=master --version 1.23`

* Running on worker: `docker run --pid=host -v /etc:/etc:ro -v /var:/var:ro -t aquasec/kube-bench:latest run --targets=node --version 1.23`

* Running on GKE
  * Download this [job](https://github.com/aquasecurity/kube-bench/blob/main/job-gke.yaml)
  * `kubectl apply -f job-gke.yaml`
  * `kube logs kube-bench-XXXXX`
