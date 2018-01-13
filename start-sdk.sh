#!/bin/bash

. .venv/bin/activate
./isi_data_insights_d.py -c /etc/data_insights/isi_data_insights_d.cfg start
tail -F isi_data_insights_d.log
