param frontdoors_afd_krc_001_name string = 'afd-krc-001'

resource frontdoors_afd_krc_001_name_resource 'Microsoft.Network/frontdoors@2020-05-01' = {
  name: frontdoors_afd_krc_001_name
  location: 'Global'
  properties: {
    routingRules: [
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/RoutingRules/rule1'
        name: 'rule1'
        properties: {
          routeConfiguration: {
            forwardingProtocol: 'HttpsOnly'
            backendPool: {
              id: '${frontdoors_afd_krc_001_name_resource.id}/BackendPools/pool3'
            }
            '@odata.type': '#Microsoft.Azure.FrontDoor.Models.FrontdoorForwardingConfiguration'
          }
          resourceState: 'Enabled'
          frontendEndpoints: [
            {
              id: '${frontdoors_afd_krc_001_name_resource.id}/FrontendEndpoints/${frontdoors_afd_krc_001_name}-azurefd-net'
            }
          ]
          acceptedProtocols: [
            'Http'
            'Https'
          ]
          patternsToMatch: [
            '/*'
          ]
          enabledState: 'Enabled'
        }
      }
    ]
    resourceState: 'Enabled'
    loadBalancingSettings: [
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641518473978'
        name: 'loadBalancingSettings-1641518473978'
        properties: {
          resourceState: 'Enabled'
          sampleSize: 4
          successfulSamplesRequired: 2
          additionalLatencyMilliseconds: 0
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641539348998'
        name: 'loadBalancingSettings-1641539348998'
        properties: {
          resourceState: 'Enabled'
          sampleSize: 4
          successfulSamplesRequired: 2
          additionalLatencyMilliseconds: 0
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641539768040'
        name: 'loadBalancingSettings-1641539768040'
        properties: {
          resourceState: 'Enabled'
          sampleSize: 4
          successfulSamplesRequired: 2
          additionalLatencyMilliseconds: 0
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641539460067'
        name: 'loadBalancingSettings-1641539460067'
        properties: {
          resourceState: 'Enabled'
          sampleSize: 4
          successfulSamplesRequired: 2
          additionalLatencyMilliseconds: 0
        }
      }
    ]
    healthProbeSettings: [
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641518473978'
        name: 'healthProbeSettings-1641518473978'
        properties: {
          resourceState: 'Enabled'
          path: '/'
          protocol: 'Https'
          intervalInSeconds: 30
          enabledState: 'Enabled'
          healthProbeMethod: 'HEAD'
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641539768040'
        name: 'healthProbeSettings-1641539768040'
        properties: {
          resourceState: 'Enabled'
          path: '/'
          protocol: 'Https'
          intervalInSeconds: 30
          enabledState: 'Enabled'
          healthProbeMethod: 'HEAD'
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641539460067'
        name: 'healthProbeSettings-1641539460067'
        properties: {
          resourceState: 'Enabled'
          path: '/'
          protocol: 'Https'
          intervalInSeconds: 30
          enabledState: 'Enabled'
          healthProbeMethod: 'HEAD'
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641539348998'
        name: 'healthProbeSettings-1641539348998'
        properties: {
          resourceState: 'Enabled'
          path: '/'
          protocol: 'Https'
          intervalInSeconds: 30
          enabledState: 'Enabled'
          healthProbeMethod: 'HEAD'
        }
      }
    ]
    backendPools: [
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/BackendPools/pool1'
        name: 'pool1'
        properties: {
          backends: [
            {
              address: 'apim-krc-001.azure-api.net'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
              backendHostHeader: 'apim-krc-001.azure-api.net'
              enabledState: 'Enabled'
            }
          ]
          resourceState: 'Enabled'
          loadBalancingSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641518473978'
          }
          healthProbeSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641518473978'
          }
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/BackendPools/pool4'
        name: 'pool4'
        properties: {
          backends: [
            {
              address: 'spc-krc-002-api-gateway.private.azuremicroservices.io'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
              backendHostHeader: 'spc-krc-002-api-gateway.private.azuremicroservices.io'
              enabledState: 'Enabled'
            }
          ]
          resourceState: 'Enabled'
          loadBalancingSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641539768040'
          }
          healthProbeSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641539768040'
          }
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/BackendPools/pool3'
        name: 'pool3'
        properties: {
          backends: [
            {
              address: 'spc-krc-001-api-gateway.azuremicroservices.io'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
              backendHostHeader: 'spc-krc-001-api-gateway.azuremicroservices.io'
              enabledState: 'Enabled'
            }
          ]
          resourceState: 'Enabled'
          loadBalancingSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641539460067'
          }
          healthProbeSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641539460067'
          }
        }
      }
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/BackendPools/pool2'
        name: 'pool2'
        properties: {
          backends: [
            {
              address: '52.141.19.153'
              httpPort: 80
              httpsPort: 443
              priority: 1
              weight: 50
              backendHostHeader: '52.141.19.153'
              enabledState: 'Enabled'
            }
          ]
          resourceState: 'Enabled'
          loadBalancingSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/LoadBalancingSettings/loadBalancingSettings-1641539348998'
          }
          healthProbeSettings: {
            id: '${frontdoors_afd_krc_001_name_resource.id}/HealthProbeSettings/healthProbeSettings-1641539348998'
          }
        }
      }
    ]
    frontendEndpoints: [
      {
        id: '${frontdoors_afd_krc_001_name_resource.id}/FrontendEndpoints/${frontdoors_afd_krc_001_name}-azurefd-net'
        name: '${frontdoors_afd_krc_001_name}-azurefd-net'
        properties: {
          resourceState: 'Enabled'
          hostName: '${frontdoors_afd_krc_001_name}.azurefd.net'
          sessionAffinityEnabledState: 'Disabled'
          sessionAffinityTtlSeconds: 0
        }
      }
    ]
    backendPoolsSettings: {
      enforceCertificateNameCheck: 'Enabled'
      sendRecvTimeoutSeconds: 30
    }
    enabledState: 'Enabled'
    friendlyName: frontdoors_afd_krc_001_name
  }
}