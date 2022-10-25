param gLocation string = 'westus'

param spc_name string = 'spc-usw-001'

param vnet_name string = 'vnet-usw-021'

//Azure Spring Cloud reserved CIDR range
param spc_CIDR string = '10.0.0.0/16,10.1.0.0/16,10.2.0.1/16'

param resourceGroupName string = resourceGroup().name

param spc_sku object = {
    name: 'S0'
    tier: 'Standard'
}

resource vnet_name_resource 'Microsoft.Network/virtualNetworks@2020-05-01' existing = {
  name: vnet_name
}

resource spc_name_resource 'Microsoft.AppPlatform/Spring@2021-09-01-preview' = {
  name: spc_name
  tags: {
    depl: 'petclinic'
  } 
  location: gLocation
  sku: spc_sku
  properties: {
    networkProfile: (spc_sku.tier == 'Basic') ? null : {
      serviceRuntimeSubnetId: '${vnet_name_resource.id}/subnets/sub1'
      appSubnetId: '${vnet_name_resource.id}/subnets/sub2'
      serviceCidr: spc_CIDR
      serviceRuntimeNetworkResourceGroup: '${resourceGroupName}-${spc_name}-svcrt'
      appNetworkResourceGroup: '${resourceGroupName}-${spc_name}-app'
    }
  }
  //dependsOn: [
  //  vnet_name_resource
  //]  
}