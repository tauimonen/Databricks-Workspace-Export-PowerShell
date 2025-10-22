<#
    ===========================================
    Databricks Workspace Export PowerShell
    ===========================================
    This script goes through all notebooks in a Databricks workspace
    and saves them to a local folder.
    Clearly edit the marked sections before use.
#>

# =========================
# 1️⃣ EDIT THESE SECTIONS
# =========================

# Databricks workspace host (e.g., https://adb-1234567890123456.7.azuredatabricks.net)
$DatabricksHost = "https://<YOUR HOST>"

# Personal access token
$Token = "<YOUR TOKEN>"

# Local folder where notebooks will be saved
$TargetFolder = "C:\Users\<USER>\Desktop\Databricks_Exports"

# =========================
# 2️⃣ Do not edit the code below
# =========================

# Create folder if it doesn't exist
if (-not (Test-Path $TargetFolder)) { New-Item -ItemType Directory -Path $TargetFolder | Out-Null }

# Function to export a notebook
function Export-Notebook($Path, $OutDir) {
    $Url = "$DatabricksHost/api/2.0/workspace/export"
    $Body = @{ path = $Path; format = "SOURCE" } | ConvertTo-Json
    $Headers = @{ Authorization = "Bearer $Token"; "Content-Type" = "application/json" }

    try {
        $Resp = Invoke-RestMethod -Method GET -Uri $Url -Body $Body -Headers $Headers
        $Content = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Resp.content))
        $FileName = Join-Path $OutDir (($Path -split "/")[-1] + ".py")
        $Content | Out-File -FilePath $FileName -Encoding utf8
        Write-Host "Exported: $Path → $FileName"
    }
    catch {
        Write-Warning "Failed to export: $Path. $_"
    }
}

# Function to traverse a directory (recursive)
function Export-Folder($WorkspacePath, $LocalPath) {
    $Url = "$DatabricksHost/api/2.0/workspace/list?path=$WorkspacePath"
    $Headers = @{ Authorization = "Bearer $Token" }
    $Resp = Invoke-RestMethod -Method GET -Uri $Url -Headers $Headers

    foreach ($Obj in $Resp.objects) {
        $ObjectPath = $Obj.path
        if ($Obj.object_type -eq "NOTEBOOK") {
            Export-Notebook $ObjectPath $LocalPath
        }
        elseif ($Obj.object_type -eq "DIRECTORY") {
            # Create a subfolder locally
            $SubFolderName = ($ObjectPath -split "/")[-1]
            $NewLocalPath = Join-Path $LocalPath $SubFolderName
            if (-not (Test-Path $NewLocalPath)) { New-Item -ItemType Directory -Path $NewLocalPath | Out-Null }
            # Recursively traverse the subdirectory
            Export-Folder $ObjectPath $NewLocalPath
        }
    }
}

# Start export from the root
Export-Folder "/" $TargetFolder
Write-Host "==============================================="
Write-Host "All workspace notebooks have been exported!"
Write-Host "==============================================="
