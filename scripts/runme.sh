#!/bin/bash

# create directory
ssh developer@192.168.50.222 "mkdir -p /opt/services/app/src"

# copy contents to target server
scp -r /home/developer/src/stackdemo/. developer@192.168.50.222:/opt/services/app/src
