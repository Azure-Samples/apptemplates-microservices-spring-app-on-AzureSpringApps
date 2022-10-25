param gLocation string = 'westus'

param mysql_name string = 'mysql-usw-001'

param mysql_sku object = {
  name: 'GP_Gen5_4'
  tier: 'GeneralPurpose'
  family: 'Gen5'
  capacity: 4
}

param mysql_version string = '5.7'

param mysql_adminUsername string = 'azureuser'
param mysql_adminPassword string = 'pass&1234'

param database_name string = 'petclinic'

param firewall_rules array = [
  {
    name: 'allAzureIPs'
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
  {
    name: 'myDevMachine1'
    startIpAddress: '218.152.13.89'
    endIpAddress: '218.152.13.89'
  }
  {
    name: 'myDevMachine2'
    startIpAddress: '172.16.10.8'
    endIpAddress: '172.16.10.8'
  }
]

param database_config array = [
  {
    name: 'wait_timeout'
    value: '2147483'
    source: 'user-override'
  }
//  {
//    name: 'time_zone'
//    value: 'US/Pacific'
//    source: 'user-override'
//  }
]

resource mysql_name_resource 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: mysql_name
  location: gLocation
  sku: mysql_sku
  properties: {
    createMode: 'Default'
    administratorLogin: mysql_adminUsername
    administratorLoginPassword: mysql_adminPassword
    storageProfile: {
      storageMB: 102400
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
      storageAutogrow: 'Enabled'
    }
    version: mysql_version
    sslEnforcement: 'Disabled'
    minimalTlsVersion: 'TLSEnforcementDisabled'
    infrastructureEncryption: 'Disabled'
    publicNetworkAccess: 'Enabled'
  }
}

resource database_name_resource 'Microsoft.DBforMySQL/servers/databases@2017-12-01' = {
  name: '${mysql_name_resource.name}/${database_name}'
  properties: {
    charset: 'latin1'
    collation: 'latin1_swedish_ci'
  }
  dependsOn: [
    mysql_name_resource
  ]
}

resource fwrule_name_resource 'Microsoft.DBforMySQL/servers/firewallRules@2017-12-01' = [for item in firewall_rules: {
  name: '${mysql_name_resource.name}/${item.name}'
  properties: {
    startIpAddress: item.startIpAddress
    endIpAddress: item.endIpAddress
  }  
  dependsOn: [
    mysql_name_resource
  ]
}]

resource securityAlertPolicies_name_resource 'Microsoft.DBforMySQL/servers/securityAlertPolicies@2017-12-01' = {
  name: '${mysql_name_resource.name}/Default'
  properties: {
    state: 'Enabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    mysql_name_resource
  ]
}

resource mysql_name_wait_timeout 'Microsoft.DBforMySQL/servers/configurations@2017-12-01' = [for item in database_config: {
  name: '${mysql_name_resource.name}/${item.name}'
  properties: {
    value: item.value
    source: item.source
  }  
  dependsOn: [
    mysql_name_resource
  ]
}]