Write-Host "-----------------------------------------------------------------------------------"

$caThumbprint = "0b710ea41dfbc14bbab778ee2de1f2349c1189f1"
#查找用户证书
$userCert = Get-ChildItem -Path Cert:\CurrentUser\Root | Where-Object { $_.Thumbprint -eq $caThumbprint }
if ($userCert) {
    Write-Host "当前用户下存在证书："
    $userCert.Subject
    $userCert.Thumbprint
} else {
    Write-Host -BackgroundColor Red "当前用户下未找到具有该指纹的证书！"
}

Write-Host "-----------------------------------------------------------------------------------"
#查找本地证书
$localCert = Get-ChildItem -Path Cert:\LocalMachine\Root | Where-Object { $_.Thumbprint -eq $caThumbprint }
if ($localCert) {
    Write-Host "本地计算机下存在证书："
    $localCert.Subject
    $localCert.Thumbprint
} else {
    Write-Host -BackgroundColor Red "本地计算机未找到具有该指纹的证书！"
}

Write-Host "-----------------------------------------------------------------------------------"
#查找注册表项
$path = "HKLM:\SOFTWARE\LarkNetSetting"
if(Test-Path $path){
    Write-Host "注册表路径存在"
    $registry=  Get-ItemProperty $path
    if($registry.DisableHTTPDNS -eq "1" -and $registry.DisableSSLPining -eq "1"){
        Write-Host "注册表项值正确"
    }else{
        Write-Host -BackgroundColor Red "注册表项值错误！"
    }
    $registry
}else{
    Write-Host -BackgroundColor Red "注册表路径不存在！"
}

Write-Host "-----------------------------------------------------------------------------------"
#查找hosts文件
$hostsInfo = Get-Content "C:\Windows\System32\drivers\etc\hosts"
$hosts1 = "14.103.184.100 internal-api-security-tenant-probe.feishu.cn"
$hosts2 = "14.103.184.100 accounts.feishu.cn"
$clearHosts = $null
Write-Host "过滤后hosts文件内容："
for($i=0;$i -lt $hostsInfo.Length;$i++){
    if($hostsInfo[$i] -notmatch "#" ){
        $hostsInfo[$i]
        $clearHosts += $hostsInfo[$i]
    }
}
Write-Host "`n"
if($clearHosts -match $hosts1 -and $clearHosts -match $hosts2){
    Write-Host "hosts文件包含指定内容"
}else{
    Write-Host -BackgroundColor Red "hosts文件内未找到指定挟持内容！"
}

Write-Host "-----------------------------------------------------------------------------------"
Read-Host "按下任意键关闭"