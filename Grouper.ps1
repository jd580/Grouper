#############################################################
# Script to group files into directories based on extension.#
# I use it to organize the downloads directory.             #
#############################################################

$path = Read-Host "Enter the path you would like to have sorted: "

# Validate path.
if (-not $(test-path -Path "$path")){
    Write-Error -Message "Invalid Path."
    Break
}

# Get the extensions in the path.
Set-Location $path
$files = Get-ChildItem -Path $path -File 
$extensions = $files.Extension | Select-Object -Unique

# Make directories for each type of extension.
foreach ($extension in $extensions) {
    if (-not $(test-path -Path "$path\$extension")){
        New-Item -Path "$path\$extension" -ItemType Directory
    }
}

# Move the files.
foreach ($file in $files) {
    Move-Item -Path $file.PSPath -Destination "$path\$($file.Extension)\"
    Write-Host "Moving $file to $path\$($file.Extension)\$file"
}
