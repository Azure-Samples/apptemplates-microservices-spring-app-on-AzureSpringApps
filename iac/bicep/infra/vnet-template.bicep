param gLocation string = 'westus'

param vnet_name string = 'vnet-usw-021'
param vnet_addressPrefix string = '10.21.0.0/16'

param subnets array = [
  {
    name: 'default'
    addressPrefix: '10.21.0.0/24'
  }
  {
    name: 'sub1'
    addressPrefix: '10.21.1.0/24'
  }
  {
    name: 'sub2'
    addressPrefix: '10.21.2.0/24'
  }
]

resource vnet_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnet_name
  tags: {
    depl: 'petclinic'
  } 
  location: gLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet_addressPrefix
      ]
    }
    subnets: [for subnet in subnets: {
      name: subnet.name
      properties: {
        addressPrefix: subnet.addressPrefix
        delegations: []
        privateEndpointNetworkPolicies: 'Enabled'
        privateLinkServiceNetworkPolicies: 'Enabled'        
      }
    }]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

/**
resource symbolicname 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: 'string'
  scope: vnet_name_resource
  properties: {
    roleDefinitionId: 'Owner'
    principalId: 'e8de9221-a19c-4c81-b814-fd37c6caf9d2'
 
    //condition: 'string'
    //conditionVersion: 'string'
    //delegatedManagedIdentityResourceId: 'string'
    //description: 'string'
    //principalId: 'string'
    //principalType: 'string'
    //roleDefinitionId: 'string'
  }
}
*/