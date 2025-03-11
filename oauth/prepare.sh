#!/usr/bin/env bash

openssl genrsa -out keypair.pem 2048
openssl rsa -in keypair.pem -outform PEM -pubout -out public.pem