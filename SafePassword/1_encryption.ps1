#账号密码
#$adminUser = "xazj\it"
#$adminPassword = "Elite123@@"
#转换为安全字符
#$password = ConvertTo-SecureString $adminPassword -AsPlainText -Force

#手动输入，避免明文
#$adminUser = Read-Host "Enter the administrator username"
#$adminPassword = Read-Host "Enter the password" -AsSecureString


# 创建PSCredential对象
$credential = New-Object System.Management.Automation.PSCredential ($adminUser, $adminPassword)
# 将密码转换为加密格式
$encryptedPassword = ConvertFrom-SecureString $credential.Password
# 保存加密后的密码到文件
$encryptedPassword | Out-File -FilePath "C:\efi\update\encryptedCredential.txt"







