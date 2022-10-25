#!/bin/bash

fdotenv () {
  set -a
  [ -f .env ] && . .env
  set +a
} 

fdotenv

az monitor log-analytics workspace create \
    --workspace-name ${LOG_ANALYTICS} \
    --resource-group ${RESOURCE_GROUP} \
    --location ${REGION}

export LOG_ANALYTICS_RESOURCE_ID=$(az monitor log-analytics workspace show \
    --resource-group ${RESOURCE_GROUP} \
    --workspace-name ${LOG_ANALYTICS} | jq -r '.id')

export SPRING_CLOUD_RESOURCE_ID=$(az spring-cloud show \
    --name ${SPRING_CLOUD_SERVICE} \
    --resource-group ${RESOURCE_GROUP} | jq -r '.id')

az monitor diagnostic-settings create --name "send-logs-and-metrics-to-log-analytics" \
    --resource ${SPRING_CLOUD_RESOURCE_ID} \
    --workspace ${LOG_ANALYTICS_RESOURCE_ID} \
    --logs '[
         {
           "category": "ApplicationConsole",
           "enabled": true,
           "retentionPolicy": {
             "enabled": false,
             "days": 0
           }
         },
         {
            "category": "SystemLogs",
            "enabled": true,
            "retentionPolicy": {
              "enabled": false,
              "days": 0
            }
          },
         {
            "category": "IngressLogs",
            "enabled": true,
            "retentionPolicy": {
              "enabled": false,
              "days": 0
             }
           }
       ]' \
       --metrics '[
         {
           "category": "AllMetrics",
           "enabled": true,
           "retentionPolicy": {
             "enabled": false,
             "days": 0
           }
         }
       ]'