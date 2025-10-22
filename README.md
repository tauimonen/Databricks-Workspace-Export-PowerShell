# Databricks Workspace Export PowerShell

This PowerShell script recursively exports all notebooks from a Databricks workspace to a local folder.  

## Features

- Exports all notebooks in the workspace.
- Maintains the folder structure locally.
- Saves notebooks in Python `.py` source format.
- Handles nested directories recursively.

## Requirements

- PowerShell 5.1 or later
- A Databricks workspace
- Personal Access Token for Databricks

## Setup

1. Clone or download this repository.
2. Open the script in a text editor.
3. Edit the following variables at the top of the script:

```powershell
# Databricks workspace host (e.g., https://adb-1234567890123456.7.azuredatabricks.net)
$DatabricksHost = "https://<YOUR HOST>"

# Personal access token
$Token = "<YOUR TOKEN>"

# Local folder where notebooks will be saved
$TargetFolder = "C:\Users\<USER>\Desktop\Databricks_Exports"
```

## Usage 

1. Open PowerShell.
2. Navigate to the folder containing the script.
3. Run the script:
   
```powershell
.\Export-DatabricksWorkspace.ps1
```
The script will recursively export all notebooks from the workspace and save them in the specified local folder.

## Output

- Notebooks are exported in `.py` format.
- Folder structure of the workspace is preserved locally.
- Export progress is printed in the console.

## Notes
- Do not modify the main functions unless you know what you are doing.
- Ensure your Personal Access Token has the required permissions to read notebooks.

## License

This project is licensed under the MIT License.

MIT License

Copyright (c) 2025 tauimonen

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


