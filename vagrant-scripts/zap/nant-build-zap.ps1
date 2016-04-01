# Clean and Build
$base_dir = Get-Location 
Write-Host "Zap NAnt build..."
$dsp_dir = "C:\dsp"
$nant = "C:\zap\tools\NAnt\nant-0.85\bin\NAnt.exe"
$build_file = "Build\NAnt\default.build"

$repos = dir -Directory $dsp_dir | ForEach-Object { $_.Name }
ForEach ($repo in $repos) {
	echo $repo
	if ($repo.StartsWith("Zap.Services") -or $repo.StartsWith("Zap.Libraries") -and !($repo.StartsWith("."))) {
		$dest_dir = "$dsp_dir\$repo\Product\Production"
		$build_dir = "$dsp_dir\$repo\$build_file"
		Set-Location -Path $dest_dir 
		& $nant -buildfile:"$build_dir"
	}
}

Set-Location $base_dir
