# Becoming a Rockstar SRE

<a href="https://www.packtpub.com/product/becoming-a-rockstar-sre/9781803239224"><img src="https://static.packt-cdn.com/products/9781803239224/cover/smaller" alt="Becoming a Rockstar SRE" height="256px" align="right"></a>

This is the code repository for [Becoming a Rockstar SRE](https://www.packtpub.com/product/becoming-a-rockstar-sre/9781803239224), published by Packt.

**Electrify your site reliability engineering mindset to build reliable, resilient, and efficient systems**

## What is this book about?
Site reliability engineering is all about continuous improvement, finding the balance between business and product demands while working within technological limitations to drive higher revenue. But quantifying and understanding reliability, handling resources, and meeting developer requirements can sometimes be overwhelming. With a focus on reliability from an infrastructure and coding perspective, Becoming a Rockstar SRE brings forth the site reliability engineer (SRE) persona using real-world examples.

This book covers the following exciting features:
* Get insights into the SRE role and its evolution, starting from Google’s original vision
* Understand the key terms, such as golden signals, SLO, SLI, MTBF, MTTR, and MTTD
* Overcome the challenges in adopting site reliability engineering
* Employ reliable architecture and deployments with serverless, containerization, and release strategies
* Identify monitoring targets and determine observability strategy
* Reduce toil and leverage root cause analysis to enhance efficiency and reliability
* Realize how business decisions can impact quality and reliability

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1803239220) today!

## Instructions and Navigations
All of the code is organized into folders. For example, Chapter06.

The code will look like the following:
```
provider "google" {
 credentials = file("project-service-account-key.json")
 project = "autoscaling-simulation-lab"
 region = "southamerica-east1"
 zone = "southamerica-east1-a"
}

```

**Following is what you need for this book:**
This book is for IT professionals, including developers looking to advance into an SRE role, system administrators mastering technologies, and executives experiencing repeated downtime in their organizations. Anyone interested in bringing reliability and automation to their organization to drive down customer impact and revenue loss while increasing development throughput will find this book useful. A basic understanding of API and web architecture and some experience with cloud computing and services will assist with understanding the concepts covered.

With the following software and hardware list you can run all code files present in the book (Chapter 1-15).
### Software and Hardware List
| Chapter | Software required | OS required |
| -------- | ------------------------------------ | ----------------------------------- |
| 1-17 | GitHub | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Kubernetes | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Node.js | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Prometheus | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Grafana | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Terraform | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Python | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Golang | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Slack | Windows, Mac OS X, and Linux (Any) |
| 1-17 | PagerDuty | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Grype | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Syft | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Argo CD | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Grafana k6 | Windows, Mac OS X, and Linux (Any) |
| 1-17 | LitmusChaos | Windows, Mac OS X, and Linux (Any) |
| 1-17 |  Google Cloud Platform account | Windows, Mac OS X, and Linux (Any) |
| 1-17 | AWS account (alternative) | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Microsoft Azure account (alternative) | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Google Kubernetes Engine (GKE) | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Google Compute Engine (GCE) | Windows, Mac OS X, and Linux (Any) |
| 1-17 | Amazon Elastic Kubernetes Service (alternative) | Windows, Mac OS X, and Linux (Any) |
| 1-17 |  Azure Kubernetes Service (alternative) | Windows, Mac OS X, and Linux (Any) |

We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it]( https://static.packt-cdn.com/downloads/9781803239224_ColorImages.pdf).

### Related products
* Cloud-Native Observability with OpenTelemetry [[Packt]](https://www.packtpub.com/product/cloud-native-observability-with-opentelemetry/9781801077705) [[Amazon]](https://www.amazon.com/dp/1801077703)

* SAFe® for DevOps Practitioners [[Packt]](https://www.packtpub.com/product/safe-for-devops-practitioners/9781803231426) [[Amazon]](https://www.amazon.com/dp/1803231424)

## Get to Know the Authors
**Jeremy Proffitt**
is passionate about solving problems with an unmatched sense of urgency - the definition of a Site Reliability Engineer. A master of solutions and technology knowledge, Jeremy is a rockstar SRE with AWS Professional Certifications in Architecture and DevOps. He has routinely saved millions in potential lost revenue in his career. In his free time, Jeremy enjoys sending time in his rockstar-appropriate man cave and loves venturing into 3D printing, electronics, and Internet of Things (IoT) projects. Jeremy currently manages a team of top SRE and DevOps talent, driving constant improvement, and is often cited in the company as a visionary of observability and emergency response.
**Rod Anami**
is a seasoned engineer, working with cloud infrastructure and software engineering technologies. As one of the Site Reliability Engineers at Kyndryl CoE, he coaches other SREs on running IT modernization, transformation, and automation projects for clients worldwide. Rod leads the global SRE guild inside Kyndryl, where he helps to grow the SRE chapters in many countries. Rod is certified as an SRE, Technical Specialist, and DevOps Engineer professional at their ultimate levels. He holds AWS, HashiCorp, Azure, and Kubernetes certificates, among others. He is passionate about contributing to the open-source software at large with Node.js libraries.

