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
$ClientsList = MySQL -Query "SELECT clients.name FROM clients JOIN extrafielddata ON (extrafielddata.id = clients.ClientID) JOIN extrafield ON (extrafield.id = extrafielddata.extrafieldid) WHERE extrafield.name LIKE 'Enable SophosCloud Deployment'AND extrafielddata.value = 1"
$BasePath = "C:\LTShare\Transfer\Software\SophosCloud"

foreach ($client in $ClientsList)
    {
      $folderpath = $BasePath + '\' + $($client).name
      if(!(Test-Path $folderpath))
        {
          New-Item $folderpath -ItemType Directory
        }
    }