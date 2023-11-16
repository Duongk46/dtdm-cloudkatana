
$AzMgmtDCRequest = Get-CKDeviceCode -ClientId $clientID -Resource $AzManagementUrl 
$AzMgmtDCRequest
$deviceCode = $AzMgmtDCRequest.device_code


# $AzMgmtDCRequest
$rs = Get-CKAccessToken -ClientId $clientID -TenantId $tenantId -GrantType "device_code" -DeviceCode $deviceCode
$accessToken = $rs.access_token
Write-Host $accessToken

# tạo resource group nếu mà nó không tồn tại thì nó tạo còn không thì không
$resourceGroup = New-CKAzResourceGroup -name $ResourceGroupName -location southeastasia -subscriptionId $subscriptionId -accessToken $accessToken
# tạo user-assinged managed identity nếu tồn tại thì không tạo và ngược lại
$identity = New-CKAzADManagedIdentity -name $IdentityName -subscriptionId $SubscriptionId -resourceGroupName $ResourceGroupName -accessToken $accessToken

