# SQL Server Database creation for Zap
Write-Host "SQL Server Database creation for Zap"
$dsp_dir = "C:\dsp"
$server ="localhost"
$sql_cmd = "C:\Program Files\Microsoft SQL Server\110\Tools\Binn\SQLCMD.EXE"

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
