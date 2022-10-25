@description('Location to create all resources')
param location string = 'westus'

@description('Project name')
param projectName string = 'spcm013'

@description('Database name')
param database_name string = 'petclinic'

@description('MySQL username')
param mysql_adminUsername string = 'azureuser'

@description('MySQL password')
param mysql_adminPassword string = 'pass&1234'

var vVaultsName = '${projectName}-keyvault'
var vMySQLName = '${projectName}-mysql'
var vEventHubName = '${projectName}-eventhub'
var vRedisName = '${projectName}-redis'
var vCosmoDBName = '${projectName}-cosmosdb'
var vAPIMName = '${projectName}-apim'

param servicePrincipal object = {
  clientId: '--'
  tenantId: '--'
  objectId: '--'
}

module stgKV 'services/keyvault-template.bicep' = {
  name: 'create-keyvault'
  params: {
    gLocation: location
    vaults_name: vVaultsName
    servicePrincipal_clientId: servicePrincipal.clientId
    servicePrincipal_tenantId: servicePrincipal.tenantId
    servicePrincipal_objectId: servicePrincipal.objectId

    secret_spring_datasource_password : mysql_adminPassword
  }
}

module stgMySQL 'services/mysql-template.bicep' = {
  name: 'create-mysql'
  params: {
    gLocation: location
    mysql_name: vMySQLName

    database_name: database_name
    mysql_adminUsername: mysql_adminUsername
    mysql_adminPassword: mysql_adminPassword
  }
}

module stgEH 'services/eventhub-template.bicep' = {
  name: 'create-eventhub'
  params: {
    gLocation: location
    eventhub_ns_name: vEventHubName
  }
}

module stgRedis 'services/redis-template.bicep' = {
  name: 'create-redis'
  params: {
    gLocation: location
    redis_name: vRedisName
  }
}

module stgCSMS 'services/csms-template.bicep' = {
  name: 'create-cosmosdb'
  params: {
    gLocation: location
    csms_name: vCosmoDBName
  }
}

module stgAPIM 'services/apim-template.bicep' = {
  name: 'create-apim'
  params: {
    location: location
    apiManagementServiceName: vAPIMName
    publisherEmail: 'admin@acme.com'
    publisherName: 'acme dev'
    sku: 'Standard'
  }
}
