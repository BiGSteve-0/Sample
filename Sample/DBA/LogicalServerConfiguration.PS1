
# 1. Configure a default resource group and an Azure SQL Database logical server
# Set up my ETL project in Azure to deploy
$resourceGroup = "SomeResourceGroup"
$server = Get-AzSqlServer -ResourceGroupName $resourceGroup
$logical_server = $server.ServerName
$databaseName = Get-AzSqlDatabase `
                    -ResourceGroupName $resourceGroup `
                    -ServerName $logical_server `
                    | Where DatabaseName -like ETL*
$databaseName = $databaseName.DatabaseName

#2. Set the defaults in Cloud Shell to specify your default resource group and Azure SQL Database logical server
az configure --defaults group=$resourceGroup sql-server=$logical_server

#Run the following command to confirm that the defaults have been set
az configure --list-defaults

# List databases or list specific databases
az sql db list
az sql db show --name $databaseName
az sql db list-usages --name $databaseName