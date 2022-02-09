@description('A serverless Cosmos DB account')
resource cosmosAccount 'Microsoft.DocumentDB/databaseAccounts@2021-06-15' = {
  name: 'cosmos-${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  properties: {
    databaseAccountOfferType: 'Standard'
    locations: [
      {
        locationName: resourceGroup().location
        failoverPriority: 0
        isZoneRedundant: false
      }
    ]
    capabilities: [
      {
        name: 'EnableServerless'
      }
    ]
  }
}

// TODO: add a resource of type Microsoft.DocumentDB/databaseAccounts/sqlDatabases
//       - make the resource a nested child resource of the cosmos db account resource
//       - give the database the exact name that your function app expects (check your cosmos db input/output bindings)

// TODO: add a resource of type Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers
//       - make the resource a nested child resource of the sqlDatabases resource (i.e. Account > Database > Container)
//       - make sure to give the container the name that your function app expects (check your cosmos db input/output bindings)
//       - configure the "partitionKey" property (properties.resource.partitionKey) to match what your function app expects (again, check bindings)

// TODO: add an output for the connection string of the Cosmos DB _account_ resource
//       - hint: use the listConnectionStrings() method on the account resource
//         sample response from listConnectionStrings:
//          {
//            "connectionStrings": [
//              {
//                "connectionString": "connection-string",
//                "description": "Name of the connection string"
//              }
//            ]
//          } 
