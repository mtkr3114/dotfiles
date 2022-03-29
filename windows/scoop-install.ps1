# install scoop

# install dir
try {
    get-command scoop -ErrorAction Stop
}
catch [Exception] {
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

$SCOOP_ROOT if ($env:SCOOP) {$env:SCOOP} else {"$home\scoop"}

# install basic module
scoop install aria2
scoop install git
scoop install curl
scoop install sudo

# add bucket 
scoop bucket add extras
scoop bucket add versions

# todo nerdfont install

# chrome
scoop install googlechrome

# vscode
scoop install vscode
reg import $SCOOP_ROOT\apps\vscode\current\vscode-install-context.reg

# slack
scoop install slack

#scoop install vcredist2019

# べつのファイルに切り出す
# utf8
# PowerShell core7でもConsoleのデフォトエンコーディングはsjisなので必要
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
[System.Console]::InputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

# git log などのマルチバイト文字を表示させるため(絵文字含む)
$env:LESSCHARSET = "utf-8"
