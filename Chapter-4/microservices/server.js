'use strict';

const express = require('express');
const os = require('os');
const axios = require('axios').default;

const DefMinMem = 2000000000;
const DefListnerPort = 8080;
const FortuneAPI = 'https://digital-fortune-cookies-api.herokuapp.com/fortune';

// Constants
const PORT = process.env.PORT || DefListnerPort;
const HOST = '0.0.0.0';
const MinMemThreshold = process.env.MEMORY_THRESHOLD || DefMinMem;

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Hello World from Rod\n');
});

/*
This is a simple health checked endpoint
*/
app.get('/health', (req, res) => {
  let goodHealth = true;
  // check the health of your machine
  // if it's ok send 200 - Health is ok
  // if not, send 401 - Issue
  // res.send('Hello World from Rod');
  console.log('Free memory: ',os.freemem());
  if (os.freemem() < MinMemThreshold) {
    goodHealth = false;
  }
  if (goodHealth) {
    res.status(200).send('I am OK!\n');
  } else {
    res.status(503).send(`I am NOT feeling well!\nMemory: ${os.freemem()}`);
  }
});

/*
A fun API endpoint to be monitored
*/
app.get('/fortune', (req, res) => {
  axios.get(FortuneAPI)
  .then(function (response) {
    // handle success
    console.log(response.data);
    res.status(200).send(`<h3>Fortune:</h3> <li>${response.data.cookie.fortune} <br><br><h3>Lucky numbers:</h3> <li>${response.data.cookie.luckyNumbers}`);
  })
  .catch(function (error) {
    // handle error
    console.error(error);
    res.status(error.response.status).send(error.response.data);
  });
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
