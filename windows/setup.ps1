# windows setup script
# 1. install scoop
# 2. set utf8
# todo nerdfont install

# 1. install scoop
try {
    get-command scoop -ErrorAction Stop
}
catch [Exception] {
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

$SCOOP_ROOT = if ($env:SCOOP) {$env:SCOOP} else {"$home\scoop"}

# basic module
scoop install aria2

scoop install git
scoop install curl
scoop install sudo

# add bucket 
scoop bucket add extras
scoop install vscode

# editor
scoop install vim
scoop install neovim

# terminal
scoop install teraterm
scoop install windows-terminal
scoop install alacritty

# win-app
scoop install wireshark
scoop install slack

# browser
scoop install googlechrome

# personal
scoop install vivaldi
scoop install autohotkey
scoop install neovide

# 2. set utf8
# PowerShell core7でもConsoleのデフォトエンコーディングはsjisなので必要
[System.Console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")
[System.Console]::InputEncoding = [System.Text.Encoding]::GetEncoding("utf-8")

# git log などのマルチバイト文字を表示させるため(絵文字含む)
$env:LESSCHARSET = "utf-8"
