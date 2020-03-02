# Add Servers Programming Test

## Background

This app is a sample implementation per the requirements to show how a simple app can connect to a server and optionally provide credentials using a mock Networking Layer.

## Clarifications

There is a discrepancy between the requirements document and the mock Networking layer because the IP addresses are different and one of the addresses is an invalid IP address.  We assume that this has been a simple oversight and typo.

The following are instead being used as the IP addresses of the server:

Type of Server | IP Address string
--- | ---
No Credentials Server | `192.168.0.10`
Require Credentials Server | `192.168.0.11`
