#!/bin/bash

fdotenv () {
  set -a
  [ -f .env ] && . .env
  set +a
} 

fdotenv

CMD0="az group create
 --location $REGION 
 --name $RESOURCE_GROUP 
 --subscription $SUBSCRIPTION
 --tags depl=petclinic"
echo $CMD0 
eval $CMD0 

CMD0="az ad sp create-for-rbac 
 --name $SP_NAME 
 --role owner 
 --scopes /subscriptions/$SUBSCRIPTION/resourceGroups/$RESOURCE_GROUP 
 --sdk-auth true"
echo $CMD0 
STR0=`eval $CMD0`
echo $STR0 | jq .

T0=`echo $STR0 | jq -r .clientId`
T1=`echo $STR0 | jq -r .clientSecret`
T2=`echo $STR0 | jq -r .tenantId`
T3=`az ad sp show --id $T0 | jq -r .objectId`

./dotenv set AZURE_CLIENT_ID=$T0 AZURE_CLIENT_SECRET=$T1 AZURE_TENANT_ID=$T2 AZURE_OBJECT_ID=$T3

CMD0="az configure --defaults 
 group=$RESOURCE_GROUP 
 location=$REGION 
 spring-cloud=$SPRING_CLOUD_SERVICE"
echo $CMD0 
eval $CMD0 
