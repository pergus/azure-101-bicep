// TODO: add a resource of type Microsoft.ServiceBus/namespaces
//       - use the 'Basic' service tier

resource serviceBus 'Microsoft.ServiceBus/namespaces@2021-06-01-preview' = {
  name: 'pergus${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {    
    name: 'Basic'
    tier: 'Basic'
  }

  resource authRules 'AuthorizationRules'= {
    name: 'pergusAuth${uniqueString(resourceGroup().id)}'
    properties: {
      rights: [
        'Manage'
        'Listen'
        'Send'
      ]
    }
  }

  resource queue 'queues' = {
    name: 'thumbnailqueue'

  }
  
}
output connectionString string = serviceBus::authRules.listKeys().primaryConnectionString

// TODO: add a resource of type Microsoft.ServiceBus/namespaces/AuthorizationRules
//       - make the resource a nested child resource of the servicebus namespace resource
//       - specify 'Manage', 'Listen', 'Send' rights

// TODO: add a resource of type Microsoft.ServiceBus/namespaces/queues
//       - make the resource a nested child resource of the servicebus namespace resource
//       - make sure to give the queue the name that your function app expects
//         (i.e. if you have hardcoded the name in your function app you need to set the same name for the queue here)

// TODO: add an output for the connection string for the _AuthorizationRules resources_
//       - hint: use the listKeys() method on the authorization rule resource
//         sample response from listKeys:
//          {
//            "primaryConnectionString": "Endpoint...",
//            "secondaryConnectionString": "Endpoint...",
//            ...
//          }
