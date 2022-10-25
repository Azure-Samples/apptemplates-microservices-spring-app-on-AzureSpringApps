@description('Location to create all resources')
param location string = 'westus'

@description('Project name')
param projectName string = 'spcm013'

@description('Asking deployment mode, Basic, Standard')
param deploymentMode string = 'Basic'

var vVNETName = '${projectName}-vnet'
var vSPCName = '${projectName}-springcloud'
var vSAName = '${projectName}sa'

var vSKU0 = {
	name: 'B0'
	tier: 'Basic'
} 

var vSKU1 = {
	name: 'S0'
	tier: 'Standard'
} 

module stgVNET 'infra/vnet-template.bicep' = if(deploymentMode == 'Standard') {
  name: 'create-vnet'
  params: {
	gLocation: location
	vnet_name: vVNETName

	vnet_addressPrefix: '10.21.0.0/16'
	 	subnets: [
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
  }
}

module stgSA 'infra/sa-template.bicep' = {
  name: 'create-storage-account'
  params: {
    gLocation: location
    storageAccounts: vSAName
    
    fileShareName: 'share01'
    blobName: 'blob01'
  }
}

module stgSPC 'infra/spc-template.bicep' = {
  name: 'create-springcloud'
  params: {
    gLocation: location
    spc_name: vSPCName
    vnet_name: vVNETName

    spc_sku: ((deploymentMode == 'Basic') ? vSKU0 : vSKU1)
  }
}
