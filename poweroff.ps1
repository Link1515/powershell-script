Add-Type -AssemblyName PresentationCore,PresentationFramework

$shutdownCommand = "shutdown /s /f /t 0"

$message = @"
關機前檢查:
  ✔️ 是否已打卡
  ✔️ 是否已提交工作日誌
"@

$response = [System.Windows.MessageBox]::Show($message, "關機提醒", "YesNo", "Warning")

if ($response -eq [System.Windows.MessageBoxResult]::Yes) {
    Invoke-Expression $shutdownCommand
} else {
    Write-Host "取消關機"
}
