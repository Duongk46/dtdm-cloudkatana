
# lấy accesstoken của thằng graph để add api permission 
$tokenGraph =  Get-CKDeviceCode -ClientId $clientID -Resource $MSGraphUrl
$tokenGraph
$deviceCodeGraph = $tokenGraph.device_code
$resGraphToken = Get-CKAccessToken -ClientId $clientID -Resource $MSGraphUrl -GrantType device_code -DeviceCode $deviceCodeGraph
$accessTokenGraph = $resGraphToken.access_token
# add permissions 

# call azure function

$headers = @{
    Authorization = "Bearer $accessToken"
}

$body = @{
    activityFunction = 'Azure'
    type = 'action'
    action = 'Grant-CKPermissions'
    Name="test"
} | ConvertTo-Json -Depth 4

$testUrl = 'https://cloudkatana.azurewebsites.net/api/HttpExam?code=zDmQU9cYTdKz66Q_ZdU_x5VCXOFuuGFPKaIqDJhnBsSMAzFuqonRmg=='

$simulationResults = Invoke-RestMethod -Method Post -Uri $testUrl -Body $body -Headers $headers -ContentType 'application/json'
$simulationResults

#