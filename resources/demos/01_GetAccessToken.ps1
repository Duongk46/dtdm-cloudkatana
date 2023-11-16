
$clientID = '64df4c65-eb9f-423d-9bd0-160bfe12458d'
$tenantId = '1a8b5d28-1b16-4c61-bff9-d6309b806957'
$appSecret = '7eY8Q~QaCZwXzX.U1AqsIiGS6nlPHfJbZDSCJa~-'
$rs = Get-CKAccessToken -ClientId $clientID -TenantId $tenantId -AppSecret $appSecret -GrantType "client_credentials"
$accessToken = $rs.access_token
Write-Host "access token: " $accessToken

$headers = @{
    Authorization = "Bearer $accessToken"
}

$UPN = "md@trungkhangstevegmail.onmicrosoft.com"

$user = Invoke-RestMethod -Method Get -Uri "https://graph.microsoft.com/v1.0/users/$UPN" -Headers $headers -ContentType "application/json"

Write-Host "DisplayName: " $user.displayname " GiveName: " $user.givenName
# $url = "https://login.microsoftonline.com/$tenantId/oauth2/token"
# $body = @{
#     grant_type = "client_credentials"
#     client_id = $clientID
#     client_secret = $appSecret
#     resource = "https://graph.microsoft.com"
# }

# $res = Invoke-RestMethod -Method Post -Uri $url -Body $body -ContentType "application/x-www-form-urlencoded"

# Write-Host "Access token: " $res.access_token
