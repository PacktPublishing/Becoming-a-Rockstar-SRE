# The 12-Factor App Questionnaire

## Factor I - Codebase

### A single and unique codebase is tracked in revision control, many deploys

* Description: _Application code is continuously tracked in a version control system. There is only one codebase per app, but many deployments will exist._
* Details: Codebase [factor](https://12factor.net/codebase)
* Why: _Having different code bases for the same app leads to technical debt, merging problems, dark code, and vulnerabilities._
* System reliability impact: **2 - LOW**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
| ---- | --------------------------------------------------------------------------------------------------------------- | --------- | ------------- | ------------------------------ |
| 1.1 | Is the application source code stored in a source versioning-controlled repository? | Compliant | Non-compliant | Git, Mercurial, or Subversion  |
| 1.2 | Is the application source code stored in a single repository or multiple repositories that share a root commit? | Compliant | Non-compliant | GitHub, GitLab |
| 1.3 | Do all the deployments of this app share the same codebase? | Compliant | Non-compliant | GitHub Acations, Argo CD, CI/CD |
| | | | | |

## Factor II - Dependencies

### Explicitly declare and isolate dependencies

* Description: _The app declares all dependencies, completely and precisely, via a dependency declaration manifest. Furthermore, it uses a dependency isolation tool during execution to ensure that no implicit dependencies “leak in” from the surrounding system. The full and explicit dependency specification is applied uniformly to production and development._
* Details: Dependencies [factor](https://12factor.net/dependencies)
* Why: _Having implicit or system-wide dependencies leads to app disruptions if any changes happen to such dependencies._
* System reliability impact: **8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 2.1 | Does your code refer to or use any external components considered hardcoded? |Non-compliant | Compliant | COM components, System DLLs, GetTempPath, Windows services, Windows registry, ConfigurationManager  |
| 2.2 | Does your code perform any operations that create an external dependency? |Non-compliant | Compliant | Using filesystem, directory manipulation, file manipulation |
| 2.3 | Does your code use a dependency declaration method? | Compliant | Non-compliant | Pip (Python), npm (Node.js), Virtualenv (Python), Fatjar (Java EE – JEE), Project Object Model (POM) XML (JEE) |
| | | | | |

## Factor III - Config (Configuration)

### Store config in the environment

* Description: _The app stores config (configuration) in environment variables (often shortened to env vars or env). Env vars are easy to change between deploys without changing any code._
* Details: Config [factor](https://12factor.net/config)
* Why: _Storing application config inside the code leads to scalability constraints and security issues._
* System reliability impact: **8 - HIGHW**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 3.1 | Does your code store config (credentials, IP addresses, API tokens, hostnames) as constantss? | Non-compliant| Compliant | Username and password |
| 3.2 | Does your app strictly separate config from code? | Compliant | Non-compliant| No hardcoded settings |
|3.3 | Does you app store config in environment variables? | Compliant | Non-compliant | `export DB_URL=”https:/...”` |
| | | | | |

## Factor IV - Backing (backend) services

### Treat backing services as attached resources

* Description: _The application makes no distinction between local and third-party backing services._
* Details: Backing (backend) services [factor](https://12factor.net/backing-services)
* Why: _Resources can be attached to and detached from deploys at will. If a database resource fails, the app can switch to another database resource without changing the code._
* System reliability impact: **5 - MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 4.1 | Does the app access backing (backend) services as attached resources via a URL or other locator? | Compliant | Non-compliant | Using any cloud-based services |
| 4.2 | Does the app treat any on-premises backing services as attached resources? | Compliant | Non-compliant | Company SMTP server<br>`smtp://auth@host/` |
| | | | |

## Factor V - Build, release, run

### Strictly separate build and run stages

* Description: _The application strictly separates the build, release, and run stages._
* Details: Build, release, run [factor](https://12factor.net/build-release-run)
* Why: _Changes to the application in runtime are not restricted and only happen with a new release. The application can be easily rolled back to a previous release._
* System reliability impact: **8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 5.1 | Are the app releases changed or tampered with after it has been created? |Non-compliant | Compliant | Configuration drift |
| 5.2 | Can the app, deployed in runtime, be changed without a new build or release? |Non-compliant | Compliant | Unprotected Kubernetes cluster |
| 5.3 | Are you using an automated deployment platform? | Compliant   | Non-compliant| Argo CD |
| 5.4 | Does the current deployment orchestrator have automated rollback capabilities? |Compliant | Non-compliant| Argo Rollouts |
| | | | | |

## Factor VI - Processes

### Execute the app as one or more stateless processes

* Description: _App processes are stateless and share nothing among them._
* Details: Processes [factor](https://12factor.net/processes)
* Why: _The app takes full advantage of scalable cloud infrastructure. Service disruptions are graceful and smooth._
* System reliability impact: **3 - LOW-MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 6.1 | Does the app use sticky sessions to cache session data in memory? | Non-compliant|Compliant | Using stateful session (Servlet / Spring), webform authentication |
| 6.2 | Does the app use microservices, event-driven, or a combined architecture pattern? |Compliant  | Non-compliant| OpenAPI, Apache Kafka |
| | | | | |

## Factor VII - Port binding

### Export services via port binding

* Description: _The app is entirely self-contained and does not rely on the runtime injection of a web server into the execution environment to create a web-facing service._
* Details: Port binding [factor](https://12factor.net/port-binding)
* Why: _The app doesn’t rely on web servers or app servers._
* System reliability impact: **2 - LOW**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 7.1 | Is the app self-contained and not dependent on any web or app server? | Compliant |Non-compliant |Using Express (Node.js) or Flask (Python) |
| | | | | |

## Factor VIII - Concurrency

### Scale out via the process model

* Description: _Application processes should never spawn daemons (daemonize) or write process ID (PID) files. Instead, rely on the operating system’s process manager._
* Details: Concurrency [factor](https://12factor.net/concurrency)
* Why: _The app is scalable horizontally as well._
* System reliability impact: **5 - MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 8.1 | Does this app scale out through the native process model if there’s more demand? |Compliant | Non-compliant | Multi-threaded, parallel processing |
| 8.2 | Does this app have separate and distinct processes assigned to handle different requests and tasks?| Compliant | Non-compliant | One microservice for each type of request |
| | | | | |

## Factor IX - Disposability

### Maximize robustness with fast startup and graceful shutdown

* Description: _The application’s processes are disposable and can be started or stopped immediately._
* Details: Disposibility [factor](https://12factor.net/disposability)
* Why: _A high-reliability app has disposable processes, so it takes seconds to boot after a shutdown._
* System reliability impact: **8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 9.1 | Does this app finish processing all active requests before shutdown when it receives a termination signal (SIGTERM)?| Compliant  | Non-compliant | Two-phase commits in transactions |
| 9.2 | Does the app take over 1 minute to reboot after a shutdown?  | Non-compliant|Compliant | N/A |
| | | | | |

## Factor X - Development/production parity

### Keep development, staging, and production as similar as possible

* Description: _The application is designed for continuous deployment by keeping the gap between development and production small._
* Details: Dev/prod parity [factor](https://12factor.net/dev-prod-parity)
* Why: _Differences between backing (backend) services mean tiny incompatibilities crop up, causing code that worked and passed tests in development or staging to fail in production._
* System reliability impact: **5 - MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 10.1 | Does the app synchronize its development, staging, and production environments daily? | Compliant | Non-compliant | Similar infrastructure and configuration to proactively capture problems |
| 10.2 | Does the app use the same dataset or other backing services in all environments? |Compliant | Non-compliant | Common datasets and services for meaningful testing |
| | | | | |

## Factor XI - Logs

### Treat logs as event streams

* Description: _The app never concerns itself with routing or storing its output stream._
* Details: Logs [factor](https://12factor.net/logs)
* Why: _A critical part of any system observability is the logs. Reliable apps need to produce logging without affecting their functionalities._
* System reliability impact: **13 - VERY HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 11.1 | Does the app treat logs as streams? | Compliant  | Non-compliant | Using log4j |
| 11.2 | Does the app have code that manages specific log files? | Non-compliant | Compliant | The app handles log storage and management |
| 11.3 | Is app logging managed by a log management tool to store data separately instead of creating code that addresses the log? | Compliant | Non-compliant | Using Grafana Loki |
| | | | | |

## Factor XII - Admin processes

### Run admin/management tasks as one-off processes

* Description: _One-off (nonrepeatable) admin processes such as installation should be run in an identical environment to the app’s regular long-running processes._
* Details: Admin processes [factor](https://12factor.net/admin-processes)
* Why: _One-off (non-repeatable) admin processes run against a release, using the same code base and configuration as any process run against that release. That approach minimizes errors and inconsistencies._
* System reliability impact: **8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
| 12.1 | Does the app ship administration code with its core code? | Compliant | Non-compliant | Build to manage principle |
| 12.2 | Do the app’s one-off admin tasks run in the same (or similar) environment as its long-running regular processes? | Compliant | Non-compliant | REPL console |
| | | | | |

## End of the Document
