#!/bin/bash

openssl req -x509 \
            -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=demo.example.com/C=US/L=New York" \
            -keyout server.key -out server.crt
