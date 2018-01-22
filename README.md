# paclabs_idic
Containerized version of Isilon Data Insights Connector for querying and collecting performance statistics from Isilon Clusters

Currently this deploys the standalone collector service, to be used in conjunction with InfluxDB, Grafana and Kapacitor.
These will be developed into similar containerized services and deployed as part of a stack. 

Prior to deployment 2 edits to this file will be needed:
1. Location (hostname or IP) of Influx (time-series) database should be edited within the 'stats_processor_args:' section
2. Cluster(s) username, password and IP of node in system access zone must be edited within this file
Note: If you do not want to expose your root user credentials - username/password must be of an RBAC user role that has minimum of read-only PAPI and Statistics privileges can be entered here