function MySQL {
  Param(
  [Parameter(
  Mandatory = $true,
  ParameterSetName = '',
  ValueFromPipeline = $true)]
  [string]$Query
  )

  $MySQLAdminUserName = 'LT1'
  $MySQLAdminPassword = 'fhKzgw=3'
  $MySQLDatabase = 'LabTech'
  $MySQLHost = 'lt1'
  $ConnectionString = "server=" + $MySQLHost + ";port=3306;uid=" + $MySQLAdminUserName + ";pwd=" + $MySQLAdminPassword + ";database="+$MySQLDatabase

  Try {
    [void][System.Reflection.Assembly]::LoadWithPartialName("MySql.Data")
    $Connection = New-Object MySql.Data.MySqlClient.MySqlConnection
    $Connection.ConnectionString = $ConnectionString
    $Connection.Open()

    $Command = New-Object MySql.Data.MySqlClient.MySqlCommand($Query, $Connection)
    $DataAdapter = New-Object MySql.Data.MySqlClient.MySqlDataAdapter($Command)
    $DataSet = New-Object System.Data.DataSet
    $RecordCount = $dataAdapter.Fill($dataSet, "data")
    $DataSet.Tables[0]
    }

  Catch {
    Write-Host "ERROR : Unable to run query : $query `n$Error[0]"
  }

  Finally {
    $Connection.Close()
  }
}

$SQLQuery = @"
SELECT extrafielddata.value AS SophosClientAddr, clients.name AS ClientFolder
FROM extrafield
JOIN extrafielddata ON (extrafield.id = extrafielddata.extrafieldid)
JOIN clients ON (clients.clientid = extrafielddata.id)
WHERE extrafield.form = '3'
AND extrafield.name LIKE 'SophosCloud Login Address'
"@

$bastPath = "C:\LTShare\Transfer\Software\SophosCloud\"
$clientPaths = MySQL -Query $SQLQuery
foreach ($client in $clientPaths)
    {
        $SourcePath = $bastPath + $($client.SophosClientAddr)
        $SourcePathFiles = $bastPath + $($client.SophosClientAddr) + "\*.exe"
        $destinationPath = $bastPath + $($client.ClientFolder)
        if (Test-Path $SourcePath)
        {
            Copy-Item $SourcePathFiles $destinationPath
        }   
    }