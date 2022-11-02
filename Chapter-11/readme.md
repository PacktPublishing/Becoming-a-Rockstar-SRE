# Becoming an SRE Rockstar

### Chapter 11 - The Worker Bees - Orchestrations of Serverless, containers and Kubernetes Lab

## Understanding orchestrated worker reliabity and retries lab

### Learning objectives

* Understanding of how to make reliable calls to orchestrated workers, using http retries

* See by example, how the number of retries, workers and failures impact the overall ability to do work with the least failure

### Pre-requisite knowledge

* Understanding of workers, retries and failures

* Installation of software to install Gitpod add on for your browser

### To run this lab, you need to install Gitpod's Browser Extension 

* Download and install the [Gitpod Browser Extension](https://www.gitpod.io/docs/configure/user-settings/browser-extension)

* Launch Gitpod on this repo using the Gitpod button in the upper right of the repo page

* In the Terminal, download the Golang dependencies by typing in 
````
cd Chapter-11
go get && go build ./... 
````
* Run the test application
````
go run . -v
````
* You can change the number of servers, retries, failures and instances of tests by using command line parameters
````
  -f int
        Number of Web Servers to Fail during test (default 1)
  -i int
        Number of times to call the web servers (default 100)
  -p int
        Base Port Number to start building servers on (default 50000)
  -r int
        Number of Retries when calling to web servers fails (default 3)
  -s int
        Number of Web Servers to Build. (default 10)
  -v    Verbose Logging to Console (Info Level)
````
