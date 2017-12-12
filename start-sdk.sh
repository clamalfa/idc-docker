#!/bin/bash

cd /idic
. .venv/bin/activate
./isi_data_insights_d.py -c /etc/data_insights/isi_data_insights_d.cfg start
while true; do sleep 1000; done