# Clean and Build
$base_dir = Get-Location 
Write-Host "Zap build..."
$dsp_dir = "C:\dsp"
$msbuild = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe"
$repos = dir -Directory $dsp_dir | ForEach-Object { $_.Name }
ForEach ($repo in $repos) {
	echo $repo
	if ($repo.StartsWith("Zap.Services") -or $repo.StartsWith("Zap.Libraries") -and !($repo.StartsWith("."))) {
		$dest_dir = "$dsp_dir\$repo\Product"
		$sln = "$dest_dir\$repo.sln"
		Set-Location -Path $dest_dir 
		& $msbuild /nologo /verbosity:minimal $sln -t:Clean
		& $msbuild /nologo /verbosity:minimal $sln
	}
}

Set-Location $base_dir
