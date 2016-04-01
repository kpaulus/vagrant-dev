
function SVN-Checkout ($name, $repo, $dest){
	$svn = "C:\Program Files\TortoiseSVN\bin\SVN.exe"
	$svn_server = "http://appareo-repos:3660/svn"
	$svn_user = "kpaulus"
	$svn_pass = "KPappareo2882"
	If (!(Test-Path $dest)) {
		Write-Host "$name checkout..."
		& $svn checkout -q --username $svn_user --password $svn_pass $svn_server/$repo $dest
		Write-Host "Done."
	}
}

function Create-Directory($destDir) {
	If (!(Test-Path $destDir)) {
		New-Item -Path $destDir -ItemType Directory
		Write-Host $destDir
	}
	
}

# NAnt 0.85
$repo_url = "Software/tools/NAnt"
$dest_dir = "C:\zap\tools\NAnt"
SVN-Checkout -name "NAnt 0.85" -repo $repo_url -dest $dest_dir

# ThinkTecture IdentityServer v2.4
$repo_url = "Software/tools/ThinkTecture/Thinktecture.IdentityServer.v2.4"
$dest_dir = "C:\inetpub\wwwroot\IdentityServer"
SVN-Checkout -name "ThinkTecture IdentityServer v2.4" -repo $repo_url -dest $dest_dir
Copy-Item .\IdentitiyServer\connectionStrings.config $dest_dir\Configuration -force

# ThinkTecture AuthorizationServer v1.2.1
$repo_url = "Software/tools/ThinkTecture/Thinktecture.AuthorizationServer.v1.2.1"
$dest_dir = "C:\inetpub\wwwroot\AuthorizationServer"
SVN-Checkout -name "ThinkTecture AuthorizationServer v1.2.1" -repo $repo_url -dest $dest_dir

# Create Zap filestructure
Write-Host "Creating Zap directory filestructure..."
$dir_list = "C:\DataServicePlatform\UsageManagement\Archive\Iridium\CDR",
			"C:\DataServicePlatform\UsageManagement\Archive\Iridium\AdditionalCDR",
			"C:\DataServicePlatform\UsageManagement\Temp\Iridium\RemoteUsageSync",
			"C:\DataServicePlatform\UsageManagement\Archive\UsageSummaryInvoice",
			"C:\DataServicePlatform\UsageManagement\Temp\UsageSummaryInvoice",
			"C:\DataServicePlatform\UsageManagement\Archive\VodafoneInternational\UsageReports",
			"C:\DataServicePlatform\UsageManagement\Archive\VodafoneInternational\AdditionalUsageReports",
			"C:\DataServicePlatform\UsageManagement\Temp\VodafoneInternational\RemoteUsageSync",
			"C:\DataServicePlatform\DataManagement\SBD\MO",
			"C:\DataServicePlatform\DataManagement\SBD\MO\Temp",
			"C:\DataServicePlatform\DataManagement\Payload",
			"C:\DataServicePlatform\DataManagement\TaskProcessors",
			"C:\DataServicePlatform\DataManagement\SBD\MO",
			"C:\DataServicePlatform\DataManagement\StoredFiles",
			"C:\DataServicePlatform\UsageManagement\Archive\VodafoneInternational\OpCoCodes"

ForEach($dir in $dir_list) {
	Create-Directory -destDir $dir
}

# Copy Vodafone International OpCodes
Copy-Item OpCoCodes-01-02-2016.csv -Destination "C:\DataServicePlatform\UsageManagement\Archive\VodafoneInternational\OpCoCodes"

Write-Host "Zap checkout..."
$dsp_dir = "C:\dsp"

$list = & $SVNExe list $SVNURL
$repos = $list -split "\n"

ForEach ($repo in $repos) {
	if ($repo.StartsWith("Zap") -and $repo.EndsWith("/")) {
		$dir = $repo -replace "/", ""
		$repo_url = "Zap/Software/$dir/Trunk"
		$dest_dir = "$dsp_dir\$dir"
		SVN-Checkout -name $dir -repo $repo_url -dest $dest_dir
	}
}

Write-Host "Done."

# Run Zap.scripts SQL for ThinkTecture Identity & Authorization Servers
# SQL Server Database creation for Zap
$server ="localhost\SQLEXPRESS"
$sql_cmd = "C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE"
Write-Host "SQL Load for ThinkTecture Identity & Authorization Servers"

$ZapScripts = "C:\dsp\Zap.Scripts"
$ConfigScripts = "IdentityServerConfigurationDbScripts"
$UserScripts = "IdentityServerUsersDbScripts"
$TestDataSQL = "dbo.insert.test.data.sql"
$CreateSQL = "dbo.drop.and.create.tables.and.constraints.sql"

& $sql_cmd -S $server -i $ZapScripts\$ConfigScripts\$CreateSQL
& $sql_cmd -S $server -i $ZapScripts\$ConfigScripts\$TestDataSQL
& $sql_cmd -S $server -i $ZapScripts\$UserScripts\$CreateSQL
& $sql_cmd -S $server -i $ZapScripts\$USerScripts\$TestDataSQL

Write-Host "Done."

# SQL Server Database creation for Zap
Write-Host "SQL Server Database creation for Zap"
$repos = dir -Directory $dsp_dir | ForEach-Object { $_.Name }
ForEach ($repo in $repos) {
	if ($repo.StartsWith("Zap.Services.Core."))
	{
		echo $repo
		$db = $repo -replace "Zap.Services.Core.", ""
		& $sql_cmd -S $server -Q "CREATE DATABASE $db"
		& $sql_cmd -S $server -Q "CREATE LOGIN [$repo.Test] WITH PASSWORD='wireframe88', CHECK_POLICY=OFF;"
		& $sql_cmd -S $server -Q "ALTER AUTHORIZATION ON DATABASE::$db TO [$repo.Test];"
	}
}