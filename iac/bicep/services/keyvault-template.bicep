param gLocation string = 'westus'

param vaults_name string = 'spcm014-keyvault'

//param vnet_name string = 'vnet-usw-021'

param vaults_sku object = {
    family: 'A'
    name: 'Standard'
}

param servicePrincipal_clientId string = '----'
param servicePrincipal_tenantId string = '----'
param servicePrincipal_objectId string = '----'

param secret_spring_datasource_password string = 'petclinic'

//resource vnet_name_resource 'Microsoft.Network/virtualNetworks@2020-05-01' existing = {
//  name: vnet_name
//}  

resource vaults_name_resource 'Microsoft.KeyVault/vaults@2021-06-01-preview' = {
  name: vaults_name
  location: gLocation
  properties: {
    sku: vaults_sku
    tenantId: servicePrincipal_tenantId
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow' 
    }
    accessPolicies: [
      {
        tenantId: servicePrincipal_tenantId
        objectId: servicePrincipal_objectId
        applicationId: servicePrincipal_clientId
        permissions: {
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          certificates: [
            'all'
          ]
        }
      }
    ]
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    enableSoftDelete: true
    softDeleteRetentionInDays: 90
    enableRbacAuthorization: false
    vaultUri: 'https://${vaults_name}.vault.azure.net/'
    provisioningState: 'Succeeded'
    publicNetworkAccess: 'Enabled'
  }
}

resource vaults_name_spring_datasource_password 'Microsoft.KeyVault/vaults/secrets@2021-06-01-preview' = {
  name: '${vaults_name_resource.name}/spring-datasource-password'
  properties: {
    value: secret_spring_datasource_password
  }
}