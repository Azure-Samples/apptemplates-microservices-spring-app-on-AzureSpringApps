#!/bin/sh

# with AZURE_CONTAINER_NAME
# with AZURE_STORAGE_ACCOUNT, AZURE_STORAGE_KEY, AZURE_STORAGE_CONNECTION_STRING

dt0=`date '+%Y%m%d%H%M%S'`

echo "Target path is $dt0"

#az storage blob upload -c $AZURE_CONTAINER_NAME -f target/spotbugs.xml -n $dt0/spotbugs.xml
az storage blob upload -c $AZURE_CONTAINER_NAME -f target/spotbugsXml.xml -n $dt0/spotbugsXml.xml
az storage blob upload -c $AZURE_CONTAINER_NAME -f target/dependency-check-report.html -n $dt0/dependency-check-report.html

az storage blob upload-batch -d $AZURE_CONTAINER_NAME -s target/site --destination-path $dt0/site --verbose
az storage blob upload-batch -d $AZURE_CONTAINER_NAME -s target/surefire-reports --destination-path $dt0/surefire-reports --verbose

exit 0