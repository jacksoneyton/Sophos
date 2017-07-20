    param (
          [string] $ClientName
        , [string] $BasePath
        )

$FullPath = $BasePath + '\' + $ClientName

IF(!(Test-Path $FullPath))
    {
        New-Item -Type Directory -Path $FullPath | Out-Null
        return "Path Created"
    }
ELSE
    {
        return "Path Exists"
    }
