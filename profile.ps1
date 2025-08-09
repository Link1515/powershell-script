# 使用 TLS 1.2 進行網路安全連線
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 設定 UTF-8
[System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8
chcp 65001 | Out-Null

# 設定按下 Ctrl+w 可以刪除一個單字
Set-PSReadlineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord

# 設定按下 Ctrl+e 可以移動游標到最後面
Set-PSReadlineKeyHandler -Chord ctrl+e -Function EndOfLine

# 設定按下 Ctrl+a 可以移動游標到最前面
Set-PSReadlineKeyHandler -Chord ctrl+a -Function BeginningOfLine

# 移除內建的 curl 與 wget 命令別名
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
If (Test-Path Alias:wget) {Remove-Item Alias:wget}

# 使用 oh-my-posh
oh-my-posh init pwsh --config ~\.blue-owl.omp.json | Invoke-Expression

function hosts { nvim c:\windows\system32\drivers\etc\hosts }

function sysprop { SystemPropertiesAdvanced }

function pa { php artisan @Args }

