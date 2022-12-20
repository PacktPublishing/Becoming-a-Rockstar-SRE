'use strict';

const express = require('express');
const os = require('os');
const axios = require('axios').default;

const DefListnerPort = 8082;

// Constants
const PORT = process.env.PORT || DefListnerPort;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Hello World from Rod\n');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
