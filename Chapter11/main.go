package main

import (
	"fmt"
	"flag"
	"os"
 	"net/http"
	"math/rand"
	"time"
	"sync"
	"github.com/gofiber/fiber/v2"
	log "github.com/sirupsen/logrus"
)


var BasePort int = 50000
var IsVerbose bool = false
var ServerInstances int 
var Retries int = 0
var Iterations int = 100
var Failures int = 0

var TotalFailures int = 0
var TotalRetries int = 0

func init() {
	//Process command line flags
	flag.BoolVar(&IsVerbose,"v", false, "Verbose Logging to Console (Info Level)")
	flag.IntVar(&ServerInstances, "s",10,"Number of Web Servers to Build.")
	flag.IntVar(&Retries, "r",3,"Number of Retries when calling to web servers fails")
	flag.IntVar(&Iterations, "i",100, "Number of times to call the web servers")
	flag.IntVar(&Failures, "f",1,"Number of Web Servers to Fail during test")
	flag.IntVar(&BasePort, "p",50000, "Base Port Number to start building servers on")
	flag.Parse()

	if (Failures >= ServerInstances) {
		fmt.Printf("Decreases Failures to Server Instances Minus 1")
		Failures = ServerInstances - 1
	}

	fmt.Printf("Starting Application with %d Servers, %d Retries Set, doing %d Iterations with %d Failures, Starting with Port %d.\n",ServerInstances,Retries,Iterations,Failures, BasePort)
	
	//Set Options based on verbose console or file based logging 
	if (IsVerbose) {
		fmt.Print("Setting Verbose Logging to Console.")
		log.SetLevel(log.InfoLevel)
		log.SetOutput(os.Stdout)
		log.WithField("Verbose", IsVerbose).Info("Verbose Logging to Console (Info Level)")
	} else {
		fmt.Print("Logging to File")
		f, err := os.OpenFile("web-server.log", os.O_APPEND|os.O_CREATE|os.O_RDWR, 0666)
		if err != nil {
			fmt.Printf("error opening file: %v", err)
		}
		log.SetOutput(f)
		log.SetLevel(log.InfoLevel)
		log.WithField("Verbose", IsVerbose).Info("Logging to File")
	}

	log.WithField("Server Instances", ServerInstances).WithField("Retries", Retries).WithField("Iterations", Iterations).WithField("Failures", Failures).Info("Application Command Line Options")

	
}

var servers []*fiber.App
var failurePoints []int

func runServer(p int) {
	time.Sleep(time.Second)
	servers = append(servers, fiber.New())
	servers[p].Get("/", func(c *fiber.Ctx) error {
		return c.SendString("Hello, World!")
	})
	log.WithField("Server Port", BasePort + p).Info("Creating Web-Server")
	log.WithField("Server Port", BasePort + p).Error(servers[len(servers) - 1].Listen(fmt.Sprintf(":%d", BasePort + p)))
	
}

func main() {



	var i int
	log.WithField("Server Instances",ServerInstances).Info("Building Wait Group for Web Servers")
	//TO run multiple web servers at once, we need to build a sync wait group
	wg := new(sync.WaitGroup)
	wg.Add(ServerInstances)
	
	log.WithField("Server Instances",ServerInstances).Info("Building Web Servers")
	for port := 0; port < ServerInstances; port++ {
		go runServer(port)
		time.Sleep(time.Second)
		time.Sleep(time.Second)
	}


	log.WithField("Failures",Failures).Info("Generating random failure points")
	for i = 0; i < Failures; i++ {
		//Seed our random number generation
		rand.Seed(time.Now().UnixNano())
		failurePoints = append(failurePoints, rand.Intn(Iterations - 1))
	}

	var retry int
	var success bool
	log.WithField("Iterations",Iterations).Info("Running tests")
	for i = 0; i < Iterations; i++ {
		retry = 0
		success = false 
		log.WithField("Test Number",i).Info("Runing Test")
		for retry <= Retries && !success{
			//Seed our random number generation
			rand.Seed(time.Now().UnixNano())
			success = request( BasePort + rand.Intn(ServerInstances - 1)) 
			if !success {
				retry++
			}
		}
		log.WithField("Number of Retries", retry).WithField("Success", success).Info("Test completed")
		TotalRetries += retry
		if !success {
			TotalFailures++
		}

		if contains(failurePoints, i) {
			//Seed our random number generation
			rand.Seed(time.Now().UnixNano())
			index := rand.Intn(ServerInstances - 1)
			
			_ = servers[index].Shutdown()
			log.WithField("Server Index", index).Info("Shut down one web server to simulate failure")
			time.Sleep(time.Second)
		}

		
	}
	
	log.WithField("Failure Count", TotalFailures).WithField("RetryCount",TotalRetries).Info("Testing complete")
	fmt.Printf("In %d Iterations, %d Retries and %d Failures.\n",Iterations, TotalRetries, TotalFailures)

}

func contains(s []int, e int) bool {
    for _, a := range s {
        if a == e {
            return true
        }
    }
    return false
}

func request( port int ) bool {
	log.WithField("Port",port).Info("Calling web server")
	client := http.Client{
	 	Timeout: time.Second,
	}
	url := fmt.Sprintf("http://127.0.0.1:%d", port)
	log.WithField("url",url).Info("Making HTTP request")

	resp, err := client.Get(url)
	if (err == nil) {
		log.WithField("StatusCode",resp.StatusCode).Info(" \\--Call Sucessful")
		return true
	}

	log.Info(" \\--Call Failed")
	log.Error(err)
	return false
}