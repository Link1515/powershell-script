param (
    [ValidateSet("line", "postman", "dbeaver", "docker-desktop")]
    [string]$app
)

switch ($app) {
    "line" {
        Start-Process "$env:LOCALAPPDATA\LINE\bin\LineLauncher.exe"
    }
    "postman" {
        Start-Process "$env:LOCALAPPDATA\Postman\Postman.exe"
    }
    "dbeaver" {
        Start-Process "$env:LOCALAPPDATA\DBeaver\dbeaver.exe"
    }
    "docker-desktop" {
        Start-Process "$env:ProgramFiles\Docker\Docker\Docker Desktop.exe"
    }

    Default {
        Write-Output @"
open [app]

You can open the following apps:
line
postman
dbeaver
docker-desktop

"@
    }
}
