@description('Location to create all resources')
param location string = 'westus'

@description('Project name')
param projectName string = 'spcm013'

@description('Asking deployment mode, Basic, Standard')
param deploymentMode string = 'Basic'

var vSPCName = '${projectName}-springcloud'

param apps array = [
  {
    app_name: 'api-gateway'
  }
  {
    app_name: 'admin-server'
  }
  {
    app_name: 'customers-service'
  }
  {
    app_name: 'vets-service'
  }
  {
    app_name: 'visits-service'
  }
  {
    app_name: 'consumer'
  }
]

/*
module stgAPPS 'apps/spc-create-app-template.bicep' = [for item in apps: {
  name: 'create-apps-${item.app_name}'
  params: {
    gLocation: location
    spc_name: vSPCName
    app_name: item.app_name
  }
}]
*/

module stgAPPS 'apps/spc-deploy-app-template.bicep' = [for item in apps: {
  name: 'deploy-apps-${item.app_name}'
  params: {
    gLocation: location
    spc_name: vSPCName
    app_name: item.app_name
  }
}]
