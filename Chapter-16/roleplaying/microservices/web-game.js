'use strict';

const express = require('express');
const os = require('os');
const path = require('path');
const router = express.Router();

const DefListnerPort = 8082;

// Constants
const PORT = process.env.PORT || DefListnerPort;
const HOST = '0.0.0.0';
const K8_NODE_NAME = process.env.K8_NODE_NAME || "Undefined";
const K8_POD_NAME = process.env.K8_POD_NAME || "Undefined";
const K8_POD_NAMESPACE = process.env.K8_POD_NAMESPACE || "Undefined";
const K8_POD_SERVICE_ACCOUNT = process.env.K8_POD_SERVICE_ACCOUNT || "Undefined";
const K8_POD_IP = process.env.K8_POD_IP || "Undefined";

// App
const app = express();

app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

router.get('/',function(req,res){
  res.render('index', {
    envarName1: 'Node Name',
    envarName2: 'Pod Name',
    envarName3: 'Pod Namespace',
    envarName4: 'Pod Service Account',
    envarName5: 'Pod IP Address',
    envarValue1: K8_NODE_NAME,
    envarValue2: K8_POD_NAME,
    envarValue3: K8_POD_NAMESPACE,
    envarValue4: K8_POD_SERVICE_ACCOUNT,
    envarValue5: K8_POD_IP
  });
});;

app.use('/', router);
app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
