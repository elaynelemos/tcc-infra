#!/bin/bash

ngrok http $1 --log=stdout --config=$2 > /tmp/$1-ngrok.log &
