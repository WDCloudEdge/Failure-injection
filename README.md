# Failure-injection

## Description

Scripts to inject chaos into the microservice system.

## Quick Start

``````
pip install -r requirements.txt
``````

### Bookinfo & Hipster & Sock Shop

* static (no change in container status)

  ``````
  sh ./[namespace]/sum_chaos_cloud.sh [total_number] false
  ``````

* dynamic (changes in the number of containers occurring at the time of the failure)

  ``````
  sh ./[namespace]/sum_chaos_cloud.sh [total_number] true
  ``````

  [namespace] Indicates the namespace where the injected service is located.

  [total_number] Indicates the number of times each fault was injected into.

### Net Chaos

``````
sh ./net-chaos/chaos_service.sh [total_number]
``````

[total_number] Indicates the number of times each fault was injected into.



