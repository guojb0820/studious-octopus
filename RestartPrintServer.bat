@echo off
%1 %2
ver|find "5.">nul&&goto :Admin
mshta vbscript:createobject("shell.application").shellexecute("%~s0","goto :Admin","","runas",1)(window.close)&goto :eof
:Admin
chcp 65001
<nul set /p "=[A[K"
color 0a
echo 服务重启
echo ------------------------- 为防止多余打印，运行前请删除打印机打印队列! ------------------------
setlocal enabledelayedexpansion
set /a total_seconds=8
for /l %%i in (%total_seconds%,-1,0) do (
    echo ------------------------- %%i 秒后开始重启服务，可关闭窗口取消重启服务 -------------------------
    timeout /t 1 /nobreak >nul
    <nul set /p "=[A[K"
)
net stop "LanmanServer"
net start "LanmanServer"
net stop "Spooler"
net start "Spooler"

echo timeout 5 秒后关闭窗口
timeout 5