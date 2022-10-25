param gLocation string = 'westus'

param spc_name string = 'spcm013-springcloud'

param app_name string = 'the-app-01'

param spc_sku object = {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
}

resource spc_name_resource 'Microsoft.AppPlatform/Spring@2021-09-01-preview' existing = {
  name: spc_name
}

// app creation
resource spc_name_app 'Microsoft.AppPlatform/Spring/apps@2021-09-01-preview' = {
  name: '${spc_name_resource.name}/${app_name}'
  location: gLocation
  properties: {
    public: false
    activeDeploymentName: 'default'
    fqdn: '${spc_name}.private.azuremicroservices.io'
    httpsOnly: false
    temporaryDisk: {
      sizeInGB: 5
      mountPath: '/tmp'
    }
    persistentDisk: {
      sizeInGB: 0
      mountPath: '/persistent'
    }
    enableEndToEndTLS: false
  }
}