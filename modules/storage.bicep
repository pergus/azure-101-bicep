// TODO: replace this module with the storage.bicep file you created in the first lab
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: 'pergus${uniqueString(resourceGroup().id)}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'


  resource blobContainer 'blobServices' = {
    name: 'default'
  
    resource images 'containers' = {
      name: 'images'
      properties:{
        publicAccess: 'Blob'
      }
    }

    resource thumbnails 'containers' = {
      name: 'thumbnails'
      properties:{
        publicAccess: 'Blob'
      }
    }
  }
}

output storageAccountName string = storageAccount.name
output connectionString string = 'DefaultEndpointsProtocol=https;AccountName=${storageAccount.name};AccountKey=${storageAccount.listKeys().keys[0].value};EndpointSuffix=core.windows.net'
