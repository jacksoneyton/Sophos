    param (
          [string] $ip
        , [string] $hostname
        , [parameter(mandatory=$true)]
            [string] $user
        , [parameter(mandatory=$true)]
            [string] $pass
        , [parameter(mandatory=$true)]
          [ValidateSet("GET","PUT","POST")]
            [string] $method
        , [string] $body
        , [string] $node

    )

## Check Method Selection and Verify required parameters ##
if ($method -eq ("PUT" -or "POST"))
    {
        # Check Body is not Null #
        if([string]::IsNUllOrEmpty($body))
            {
                Write-Host "The selected method requires a value for the parameter -body" -ForegroundColor Red
                exit
            }
    }

## Set the base URL/Hostname for accessing the UTM ##
if ([string]::IsNullOrWhiteSpace($ip))
    {
        if([string]::IsNullOrWhiteSpace($hostname))
            {
                Write-Host "IP or HOSTNAME is required!" -ForegroundColor Red
                exit
            }
        else
            {
                $base = "https://" + $hostname + ":4444/api/"
            }
    }
else
    {
        $base = "https://" + $ip + ":4444/api/"
    }

#### Rework the credentials for HTTP encoded Authorization ####
# Pair the credentials #
$pair = "${user}:${pass}"

# Begin Encoding #
$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
$base64 = [System.Convert]::ToBase64String($bytes)

# Set for use in Web Request #
$apiKey = "Basic $base64"
#### END HTTP Encoding

#### Concat variables for Method specific URI ####
if ($method -eq "POST")
    {
        #Need to add parameters for specific POST requirements
        #$resource = $base + $node
    }
else
    {
        $resource = $base + "nodes/" + $node
    }
#### END Concatenation of URI ####

#### Set Security level to accept non-valid certificates ####
Try 
    {
        add-type -ErrorAction SilentlyContinue @"
                using System.Net;
                using System.Security.Cryptography.X509Certificates;
                public class TrustAllCertsPolicy : ICertificatePolicy {
                    public bool CheckValidationResult(
                        ServicePoint srvPoint, X509Certificate certificate,
                        WebRequest request, int certificateProblem) {
                        return true;
                    }
                }
"@ 
    } 
Catch 
    {

    }
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy -ErrorAction SilentlyContinue
#### END Security Level Setting ####

#### Determine Run Type and concat appropriate RestMethod ####
if ($method -eq "PUT")
    {
        Invoke-RestMethod -method $method -URI $resource -Headers @{"Authorization" = $apiKey} -Body $body -ContentType "application/json"
    }
elseif ($method -eq "GET")
    {
        Invoke-RestMethod -method $method -URI $resource -Headers @{"Authorization" = $apiKey} -ContentType "application/json"
    }