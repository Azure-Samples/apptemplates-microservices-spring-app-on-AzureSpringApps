param gLocation string = 'westus'

param redis_name string = 'redis-usw-001'

param redis_sku object = {
  name: 'Standard'
  family: 'C'
  capacity: 1
}

param redis_version string = '4.0.14'

resource redis_name_resource 'Microsoft.Cache/Redis@2020-12-01' = {
  name: redis_name
  location: gLocation
  properties: {
    redisVersion: redis_version
    sku: redis_sku
    enableNonSslPort: true
    publicNetworkAccess: 'Enabled'
    redisConfiguration: {
      'maxmemory-reserved': '50'
      'maxfragmentationmemory-reserved': '50'
      'maxmemory-delta': '50'
    }
  }
}