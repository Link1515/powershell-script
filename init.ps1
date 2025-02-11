# 調整 ExecutionPolicy 等級到 RemoteSigned
Set-ExecutionPolicy RemoteSigned -Force

# 安裝 Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# 安裝 windows terminal
choco install microsoft-windows-terminal -y

# 設定 windows terminal 快捷鍵
$shortcutPath = "$env:USERPROFILE\Desktop\wt.exe.lnk"
$targetPath = "$env:LOCALAPPDATA\Microsoft\WindowsApps\wt.exe" 

if (!(Test-Path $shortcutPath)) {
    $shell = New-Object -ComObject WScript.Shell
    $shortcut = $shell.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $targetPath
    $shortcut.Save()
}

$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut($shortcutPath)
$shortcut.Hotkey = "CTRL+ALT+T"
$shortcut.Save()

# 安裝 oh-my-posh
choco install oh-my-posh -y
$themeDownloadUrl = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/blue-owl.omp.json"
$themePath = "C:\Users\Public\Downloads\blue-owl.omp.json"
Invoke-WebRequest -Uri $themeDownloadUrl -OutFile $destinationPath

# 建立 $PROFILE 所需的資料夾
New-Item -Path $PROFILE -Type File -Force

# 設定 PowerShell 的 ProgressPreference, TLS 1.2 與 PSReadLine 快速鍵
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables#progresspreference
@"
# 修正 PowerShell 關閉進度列提示
# $ProgressPreference = 'SilentlyContinue'

# 使用 TLS 1.2 進行網路安全連線
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# 設定按下 Ctrl+d 可以退出 PowerShell 執行環境
Set-PSReadlineKeyHandler -Chord ctrl+d -Function ViExit

# 設定按下 Ctrl+w 可以刪除一個單字
Set-PSReadlineKeyHandler -Chord ctrl+w -Function BackwardDeleteWord

# 設定按下 Ctrl+e 可以移動游標到最後面(End)
Set-PSReadlineKeyHandler -Chord ctrl+e -Function EndOfLine

# 設定按下 Ctrl+a 可以移動游標到最前面(Begin)
Set-PSReadlineKeyHandler -Chord ctrl+a -Function BeginningOfLine

function hosts { nvim c:\windows\system32\drivers\etc\hosts }

# 移除內建的 curl 與 wget 命令別名
If (Test-Path Alias:curl) {Remove-Item Alias:curl}
If (Test-Path Alias:wget) {Remove-Item Alias:wget}

# 使用 oh-my-posh
oh-my-posh init pwsh --config $themePath | Invoke-Expression
"@ | Out-File $PROFILE

. $PROFILE

# 安裝常用字型
choco install nerd-fonts-sourcecodepro -y

# 安裝 git
choco install git -y
# Chocolatey 安裝 Git 後雖然有註冊 PATH 環境變數，但目前工作階段並沒有註冊
$env:Path += ';C:\Program Files\Git\cmd'

# 設定預設 Git Alias
git config --global alias.cm   "commit --amend -C HEAD"
git config --global alias.co   checkout
git config --global alias.st   status
git config --global alias.sts  "status -s"
git config --global alias.br   branch
git config --global alias.ll   "log --pretty=format:'%C(yellow)%h%C(reset) %ad [%C(cyan)%an%C(reset)]%C(yellow)%d%C(reset) %s %C(green)(%cr)%C(reset)' --date=short"
git config --global alias.lg   "log --graph --pretty=format:'%C(yellow)%h%C(reset) %ad [%C(cyan)%an%C(reset)]%C(yellow)%d%C(reset) %s' --abbrev-commit --date=short"
git config --global alias.alias "config --get-regexp ^alias\."
git config --global alias.ignore "!gi() { curl -sL https://www.gitignore.io/api/\$@ ;}; gi"
git config --global alias.iac  "!giac() { git init && git add . && git commit -m 'Initial commit' ;}; giac"
git config --global alias.rc  "!grc() { git reset --hard && git clean -fdx ;}; read -p 'Do you want to run the following commands:\ngit reset --hard && git clean -fdx\n\n(Y/N) ' answer && [[ $answer == [Yy] ]] && grc"

# 直接設定 Git 預設 user.name 與 user.email
git config --global user.name "Your Name"
git config --global user.email "you@example.com"

# 安裝常用軟體
choco install wget neovim vscode docker-desktop dbeaver postman -y

# 安裝 wsl
wsl --install

# 安裝 nvm
choco install nvm.portable -y

# 安裝 PowerShell core
choco install powershell-core -y

# 安裝 brave 瀏覽器
choco install brave --ignorechecksums -y