# Function App Variables
$functionAppName = 'FUNCTION-APP-NAME'
$azureFunctionUrl = "https://$functionAppName.azurewebsites.net"
$OrchestratorUrl = "$azureFunctionUrl/api/orchestrators/Orchestrator"

# Authorization Headers
$headers = @{
  Authorization = "Bearer $accessToken"
}

# HTTP Body
$body = @{
  activityFunction = 'Azure'
  type = 'action'
  action = 'Get-CKAzADApplication'
} | ConvertTo-Json -Depth 4

# Execute Simulation
$simulationResults = Invoke-RestMethod -Method Post -Uri $OrchestratorUrl -Body $body -Headers $headers -ContentType 'application/json'
$simulationResults

# Sleep
Start-Sleep -s 5

# Process Results
$outputResults = (Invoke-RestMethod -Uri $simulationResults.statusQueryGetUri -Headers $headers).output | ConvertFrom-Json
$outputResults | Select-Object displayName