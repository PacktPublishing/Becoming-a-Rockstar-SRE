# The 12-factor App Questionnaire

## Factor I - Codebase: One codebase tracked in revision control

* Description: _App code is always tracked in a version control system. There is only one codebase per app, but there will be many deploys of the app._
* Details: https://12factor.net/codebase
* Why: _Having different code bases for the same app leads to technical debts, merging problems, dark code, and vulnerabilities._
* System Reliability Impact:	**2 - LOW**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
| ---- | --------------------------------------------------------------------------------------------------------------- | --------- | ------------- | ------------------------------ |
| 1.1 | Is the application source code stored in a source versioning controlled repository? | Compliant | Non-compliant | Git, Mercurial, or Subversion  |
| 1.2 | Is the application source code stored in a single repository or multiple repositories that share a root commit? | Compliant | Non-compliant | GitHub, GitLab |
| 1.3 | Do all the deploys of this app share the same code base? | Compliant | Non-compliant | GitHub Acations, ArgoCD, CI/CD |
| | | | | |

## Factor II - Dependencies: Explicitly declare and isolate dependencies

* Description: _App declares all dependencies, completely and exactly, via a dependency declaration manifest. Furthermore, it uses a dependency isolation tool during execution to ensure that no implicit dependencies “leak in” from the surrounding system. The full and explicit dependency specification is applied uniformly to both production and development._
* Details:	https://12factor.net/dependencies
* Why: _Having implicit dependencies or system wide ones leads to app disruptions if any changes happen to such dependencies._
* System Reliability Impact:	**8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|2.1 |Does your code refer to or use any external components that is considered hardcoded?|Non-compliant|Compliant    |COM components, System DLLs, GetTempPath, Windows services, Windows registry, ConfigurationManager  |
|2.2 |Does your code perform any operations that create an external dependency? |Non-compliant|Compliant    |Using filesystem, directory manipulation, file manipulation |
|2.3 |Does your code use a dependency declaration method? |Compliant    |Non-compliant|Pip (Python), npm (node.js), Virtualenv (Python), Fatjar (JEE), Project Object Model - POM.xml (JEE)|
| | | | | |

## Factor III - Config: Store config in the environment

* Description: _App stores config in environment variables (often shortened to env vars or env). Env vars are easy to change between deploys without changing any code._
* Details: https://12factor.net/config
* Why: _Storing app configuration inside the code makes the application not scalable and insecure._
* System Reliability Impact: **1 - VERY LOW**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|3.1 |Does your code store config (credentials, urls, hostnames) as constants?| Non-compliant| Compliant | |
|3.2 | Does you app strict separate config from code? |Compliant | Non-compliant|App config is external to the app code |
|3.3 | Does you app store config in environment variables? |Compliant |Non-compliant|  |
| | | | | |

## Factor IV - Backing services: Treat backing services as attached resources

* Description: _App makes no distinction between local and third party backing services._
* Details: https://12factor.net/backing-services
* Why: _Resources can be attached to and detached from deploys at will. If a database resource is failing, app can switch it to another one without change the code._
* System Reliability Impact: **5 - MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|4.1 |Does  the app access backing services as attached resources via a URL or other locator?|Compliant|Non-compliant|Using any cloud-based services |
|4.2 |Does the app treat any on-premises backing services as attached resources? |Compliant|Non-compliant|Company SMTP server<br>smtp://auth@host/|
| | | | |

## Factor V - Build, release, run: Strictly separate build and run stages

* Description: _App uses strict separation between the build, release, and run stages._
* Details: https://12factor.net/build-release-run
* Why: _Changes to app in runtime are not restricted and only happens with a new release, app can be easily rollbacked to a previous release._
* System Reliability Impact: **8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|5.1 |Does the app releases be changed or tampered with after it has been created? |Non-compliant|Compliant | |
|5.2 |Can the app deploy in runtime be changed without a new build or release? |Non-compliant|Compliant | |
|5.3 |Are you using an automated deployment platform? |Compliant    |Non-compliant| |
|5.4 |Does the current deployment orchestrator have automated rollback capabilities? |Compliant |Non-compliant| |
| | | | | |

## Factor VI - Processes: Execute the app as one or more stateless processes

* Description: _App processes are stateless and share-nothing._
* Details: https://12factor.net/processes
* Why: _App takes full advantage of scalable cloud infrastructure. Service disruptions are graceful and smooth._
* System Reliability Impact: **3 - LOW MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|6.1 |Does the app uses sticky sessions to cache session data in memory? |Non-compliant|Compliant |Using stateful session (Servlet / Spring), Webform Authentication|
|6.2 |Does the app uses a microservices and/or event-driven architecture pattern?|Compliant  |Non-compliant|OpenAPI, Apache Kafka |
| | | | | |


## Factor VII - Port binding: Export services via port binding

* Description: _App is completely self-contained and does not rely on runtime injection of a web-server into the execution environment to create a web-facing service._
Details: https://12factor.net/port-binding
* Why: _App doesn't rely on web servers or app servers._
* System Reliability Impact: 2 - LOW

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|7.1 |Is the app self-cointained and doesn't depend on any web or app server?|Compliant|Non-compliant|Using Express (node.js) or flask (Python)|
| | | | | |

## Factor VIII - Concurrency: Scale out via the process model

* Description: _App processes should never daemonize or write PID files. Instead, rely on the operating system’s process manager._
* Details: https://12factor.net/concurrency
* Why: _App is scalable horizontally as well._
* System Reliability Impact: **5 - MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|8.1 |Does this app scale out through the native process model if there's more demand? |Compliant |Non-compliant|Multi-thread, parallel processing|
|8.2 |Does this app have separate and distinct processes that are assigned to handle different types of requests and tasks?|Non-compliant|Compliant    | |
| | | | | |


## Factor IX - Disposability: Maximize robustness with fast startup and graceful shutdown

* Description: _App’s processes are disposable, meaning they can be started or stopped at a moment’s notice._
Details: https://12factor.net/disposability
* Why: _High reliable apps have disposable processes, so it takes seconds to boot after a shutdown._
* System Reliability Impact: **8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|9.1 |Does this app finish processing all active requests prior to shutdown when it receives a termination signal (SIGTERM)?|Compliant  |Non-compliant| |
|9.2 |Does the app takes more than 1 minute to boot after a shutdown?  |Non-compliant|Compliant | |
| | | | | |


## Factor X - Development/production parity: Keep development, staging, and production as similar as possible

* Description: _App is designed for continuous deployment by keeping the gap between development and production small._
* Details: https://12factor.net/dev-prod-parity
* Why: _Differences between backing services mean that tiny incompatibilities crop up, causing code that worked and passed tests in development or staging to fail in production._
* System Reliability Impact: **5 - MEDIUM**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|10.1|Does the app synchorizes its development, staging, and production environments daily? |Compliant|Non-compliant| |
|10.2|Does the app use the same dataset or other backing services in all environments? |Compliant|Non-compliant| |
| | | | | |


## Factor XI - Logs: Treat logs as event streams

* Description: _App never concerns itself with routing or storage of its output stream._
* Details: https://12factor.net/logs
* Why: _A critical part of any system observability are the logs. Reliable apps need to produce logging without affecting its functionalities._
* System Reliability Impact: **13 - VERY HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|11.1|Does the app treats logs as streams? |Compliant  |Non-compliant |Using log4j |
|11.2|Does the app have code that manages specific log files? |Non-compliant|Compliant    |  |
|11.2|Is the app logging managed by a log management tool to store data separately instead of creating code that addresses the log?|Compliant |Non-compliant | |
| | | | | |


## Factor XII - Admin processes: Run admin/management tasks as one-off processes

* Description: _One-off admin processes should be run in an identical environment as the regular long-running processes of the app._
* Details: https://12factor.net/admin-processes
* Why: _One-off admin processes run against a release, using the same codebase and config as any process run against that release. That minimizes errors and inconsistencies._
* System Reliability Impact: **8 - HIGH**

| **Item ID** | **Question** | **If YES** | **If NO** | **Examples** |
|----|------------------------------------------------------------------------------------|-------------|-------------|----------------------------------------------------------------------------------------------------|
|12.1|Does the app ship administration code with its core code? |Compliant |Non-compliant |Build to manage principle |
|12.2|Does the app one-off admin tasks run in the same (or similar) environment as its long-running regular processes?|Compliant|Non-compliant|REPL console |
| | | | | |

## End of the Document
