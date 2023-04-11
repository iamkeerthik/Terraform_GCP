<powershell>
# Rename Machine
Rename-Computer -NewName "pluto-server" -Force;
[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls";
$ProgressPreference = 'SilentlyContinue'

# Install .net 
Install-WindowsFeature .NET-Framework-45-Features;
 
# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;

 # download and install chrome
 Set-Location "C:\Windows\system32"

#Change TimeZone
C:\Windows\System32\tzutil /s "AUS Eastern Standard Time"

#Install cloud-ops-agent
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.ps1", "${env:UserProfile}\add-google-cloud-ops-agent-repo.ps1")
Invoke-Expression "${env:UserProfile}\add-google-cloud-ops-agent-repo.ps1 -AlsoInstall"

#start agent
Start-Service google-cloud-ops-agent
#verify installation
Get-Service google-cloud-ops-agent

# Download the Google Cloud SDK installer
Invoke-WebRequest -Uri "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe" -OutFile "$env:TEMP\GoogleCloudSDKInstaller.exe"

# Install the Google Cloud SDK
Start-Process -FilePath "$env:TEMP\GoogleCloudSDKInstaller.exe" -ArgumentList "/install /quiet" -Wait

# Add the Google Cloud SDK to the PATH
$env:Path += ";$env:ProgramFiles\Google\Cloud SDK\google-cloud-sdk\bin"

# Test the installation
gcloud version

# Set the version of kubectl to install
$kubectl_version = "v1.26.0"

# Download the kubectl binary
Invoke-WebRequest -Uri "https://dl.k8s.io/release/$($kubectl_version)/bin/windows/amd64/kubectl.exe" -OutFile "$env:ProgramFiles\kubectl.exe"

# Add the kubectl binary to the PATH
$env:Path += ";$env:ProgramFiles"

# Test the installation
kubectl version --client

#Install Chrome 
$Path = $env:TEMP;
$Installer = "chrome_installer.exe";
Invoke-WebRequest "http://dl.google.com/chrome/install/375.126/chrome_installer.exe" -OutFile     $Path\$Installer; 
Start-Process -FilePath $Path\$Installer -ArgumentList "/silent /install" -Verb RunAs -Wait;
Remove-Item $Path\$Installer

#Set Chrome as default browser
$chromePath = "${Env:ProgramFiles(x86)}\Google\Chrome\Application\" 
$chromeApp = "chrome.exe"
$chromeCommandArgs = "--make-default-browser"
& "$chromePath$chromeApp" $chromeCommandArgs

##Download and install
Invoke-WebRequest https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.4.8/npp.8.4.8.Installer.exe -OutFile C:\Windows\Temp\npp.8.4.8.Installer.exe

Start-Process C:\Windows\Temp\npp.8.4.8.Installer.exe /S -NoNewWindow -Wait -PassThru

shutdown -r -t 10;
</powershell>