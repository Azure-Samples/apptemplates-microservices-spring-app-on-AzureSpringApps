param gLocation string = 'westus'

param eventhub_ns_name string = 'eh-usw-001'

param eventhub_ns_sku object = {
  name: 'Standard'
  tier: 'Standard'
  capacity: 1
}

param eventhub_name string = 'eh001'

param eventhub_policy_name string = 'tester01'

resource namespaces_eventhub_ns_name_resource 'Microsoft.EventHub/namespaces@2021-11-01' = {
  name: eventhub_ns_name
  location: gLocation
  sku: eventhub_ns_sku
  properties: {
    disableLocalAuth: false
    zoneRedundant: false
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
    kafkaEnabled: true
  }
}

resource eventhub_name_resource 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  name: '${namespaces_eventhub_ns_name_resource.name}/${eventhub_name}'
  properties: {
    messageRetentionInDays: 1
    partitionCount: 2
    status: 'Active'
  }
}

resource namespaces_eventhub_ns_name_default 'Microsoft.EventHub/namespaces/networkRuleSets@2021-11-01' = {
  name: '${namespaces_eventhub_ns_name_resource.name}/default'
  properties: {
    publicNetworkAccess: 'Enabled'
    defaultAction: 'Allow'
    virtualNetworkRules: []
    ipRules: []
  }
}

resource eventhub_name_resource_PreviewDataPolicy 'Microsoft.EventHub/namespaces/eventhubs/authorizationRules@2021-11-01' = {
  name: '${eventhub_name_resource.name}/PreviewDataPolicy'
  properties: {
    rights: [
      'Listen'
    ]
  }
}

resource eventhub_name_resource_tester01 'Microsoft.EventHub/namespaces/eventhubs/authorizationRules@2021-11-01' = {
  name: '${eventhub_name_resource.name}/${eventhub_policy_name}'
  properties: {
    rights: [
      'Listen'
      'Send'
    ]
  }
}

resource eventhub_name_resource_Default 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2021-11-01' = {
  name: '${eventhub_name_resource.name}/$Default'
  properties: {}
}