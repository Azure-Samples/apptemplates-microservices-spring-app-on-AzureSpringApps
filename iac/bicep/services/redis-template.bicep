param gLocation string = 'westus'

param redis_name string = 'redis-usw-001'

param redis_sku object = {
  name: 'Standard'
  family: 'C'
  capacity: 1
}

param redis_version string = 'latest'

resource redis_name_resource 'Microsoft.Cache/redis@2022-06-01' = {
  name: redis_name
  tags: {
    depl: 'petclinic'
  }   
  location: gLocation

  properties: {
    enableNonSslPort: true
    publicNetworkAccess: 'Enabled'
    redisConfiguration: {
      'maxmemory-reserved': '50'
      'maxfragmentationmemory-reserved': '50'
      'maxmemory-delta': '50'
    }
    redisVersion: redis_version
    sku: redis_sku
  }
}