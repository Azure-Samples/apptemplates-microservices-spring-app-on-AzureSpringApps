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

// app deployment
resource spc_name_app_default 'Microsoft.AppPlatform/Spring/apps/deployments@2021-09-01-preview' = {
  name: '${spc_name_app.name}/default'
  sku: spc_sku
  properties: {
    source: {
      type: 'Jar'
      relativePath: '<default>'
    }
    deploymentSettings: {
      cpu: 1
      memoryInGB: 2
      resourceRequests: {
        cpu: '1'
        memory: '2Gi'
      }
      jvmOptions: '-Xms2048m -Xmx2048m'
      runtimeVersion: 'Java_8'
    }
  }
}