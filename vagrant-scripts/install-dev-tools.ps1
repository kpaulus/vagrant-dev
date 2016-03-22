# Install Chocolatey
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))

# Install MS WebDeploy
choco install webdeploy

# Install DotNet 4.5
choco install dotnet4.5

# Install Visual Studio
choco install VisualStudio2013Ultimate

# Install Ms SQL Server 2012 Express
choco install MsSqlServer2012Express

# Install Resharper
choco install resharper

# Install Webstorm
choco install webstorm

# Install TortoiseSVN
choco install tortoisesvn

# Install Git
choco install git

# Install Mercurial
choco install hg

# Install Sublime Text 2
choco install sublimetext2

# Install Fiddler 2.4.9
choco install fiddler

# Install Sandcastle
choco install sandcastle

# Install Nant
choco install nant

# Install Google Chrome
choco install googlechrome

# Install Apache Ant
choco install ant

# Install JDK
choco install jdk8

# Install NodeJS
choco install nodejs.install

# Install ruby
choco install ruby

# Install PhantomJS
choco install phantomjs

# Install PuTTY
choco install putty

# Install NUnit
choco install nunit

# Install NServicebus MSMQ
choco install nservicebus.msmq.install

# Install Ruby Gems
Write-Host "Installing Ruby Gems..."
gem install sass
gem install compass
gem install bootstrap-sass -v 3.3.5
