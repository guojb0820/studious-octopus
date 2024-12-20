# 从文件加载加密的密码
$encryptedPassword = Get-Content "C:\efi\update\encryptedCredential.txt" | ConvertTo-SecureString

# 输入之前使用的用户名
$adminUser = "xazj\administrator"

# 用解密后的密码和用户名创建PSCredential对象
$credential = New-Object System.Management.Automation.PSCredential ($adminUser, $encryptedPassword)

# 使用凭据运行命令
Start-Process -FilePath "C:\Program Files (x86)\Feishu\uninstall.exe" -Credential $credential

#$session = New-PSSession -ComputerName "localhost" -Credential $credential

# 在会话中执行命令
#Invoke-Command -Session $session -ScriptBlock {
#    Start-Process -FilePath "C:\efi\feishu.exe" -Credential $credential -Wait
#}

# 关闭会话
#Remove-PSSession -Session $session