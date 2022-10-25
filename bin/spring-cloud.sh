#!/bin/bash

dotenv () {
  set -a
  [ -f .env ] && . .env
  set +a
}

if [ $# -lt 2 ]
  then
    echo "az spring-cloud command shorcut"
    echo "prompt>./spring-cloud.sh [task] [module]"
    echo "  tasks  : show, create, append-persistent-storage, deploy, delete, stop, start, restart, logs"
    echo "  modules: api-gateway, admin-server, customers-service, vets-service, visits-service, consumer-service"
    exit
fi

dotenv

task=$1
module=$2

cmd0="az spring-cloud app $task -n $module -s $SPRING_CLOUD_SERVICE -g $RESOURCE_GROUP --verbose "

# append option for logs
if [[ "$task" == "logs" ]]; then
    cmd0="$cmd0 -f --lines 1000"
# append option for creations
elif [[ "$task" == "create" ]]; then
    cmd0="$cmd0 --instance-count 1 --memory 2Gi --runtime-version=Java_11 --jvm-options='-Xms2048m -Xmx2048m'"
    # append more options for api-gateway and admin-server to assign public endpoints
    if [[ "$module" == "api-gateway" || "$module" == "admin-server" ]]; then
      cmd0="$cmd0 --assign-endpoint true "
    fi
# append option for storage add
elif [[ "$task" == "append-persistent-storage" ]]; then
    cmd0="$cmd0 --mount-path=/mnt/share --persistent-storage-type=AzureFileVolume --share-name=share01 --storage-name=share01 "
# append option for deploys
elif [[ "$task" == "deploy" ]]; then
    # rename consumer-service to consumer
    if [[ "$module" == "consumer-service" ]]; then
      module="consumer"
    fi
    cmd0="$cmd0 --artifact-path spring-petclinic-$module/target/*.jar --jvm-options='-Xms2048m -Xmx2048m -Dspring.profiles.active=mysql' --env ${ENV0} --no-wait"
fi

echo "Command to run : '$cmd0'"
eval $cmd0
