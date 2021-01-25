# Script CBH-1
<# .SYNOPSIS
     Docker first steps 
.DESCRIPTION
     With this functions you be able to start, stop and restart docker containers easily from powershell
.NOTES
     Author     : Victor ROdilla - victorrodilla@outlook.com
.LINK
     https://github.com/victorrodilla/
#>
  
function Get-DockerExist {
    param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    if (docker ps -a --format "table {{.Names}}" | Select-String $Name) {
        return $true
    } else {
        return $false
    }

}
Export-ModuleMember -Function Get-DockerExist

function Get-DockerStatus {

    param (
        [Parameter(Mandatory)]
        [string]$Name
    )
    
    $output = New-Object PsObject -Property @{Name=$Name}
    
    if (Get-DockerExist -Name $Name) {

        #Prepare JSON from docker inspect
        $json=docker inspect $Name | ConvertFrom-Json         #Only show docker status
        $status=$json.state.status
        
        #Create Property Status
        Add-Member -InputObject $output -MemberType NoteProperty -Name Status -Value $status

        return $output

    } else {

        #Create property Status with No Exist
        Add-Member -InputObject $output -MemberType NoteProperty -Name Status -Value "non-existent"
        return $output

    }

}
Export-ModuleMember -Function Get-DockerStatus

function Start-Docker {

    param (
        [Parameter(Mandatory)]
        [string]$Name
    )

    $status=Get-DockerStatus -Name $Name | Select-Object -Property Status -ExpandProperty Status

    if (!$status.Contains("non-existent") -and !$status.Contains("running")) {

         docker start $Name | Out-Null
         $response=docker ps -a --no-trunc --filter name=^/$Name$
         Write-Output $response  
    
    } elseif ($status.Contains("non-existent")) {

        $response="CONTAINER with name $Name is not exists"
        Write-Output $response

    } elseif ($status.Contains("running")){

        $response="CONTAINER with name $Name was previously started"
        Write-Output $response

    }

}
Export-ModuleMember -Function Start-Docker

function Stop-Docker {

    param (
        [Parameter(Mandatory)]
        [string]$Name
    )
    
    $status=Get-DockerStatus -Name $Name | Select-Object -Property Status -ExpandProperty Status

    if ($status -match "running") {

         docker stop $Name | Out-Null
         $response=docker ps -a --no-trunc --filter name=^/$Name$
         Write-Output $response 

    } elseif ($status.Contains("non-existent")) {

        $response="CONTAINER with name $Name is not exists"
        Write-Output $response

    } else {

        $response="CONTAINER with name $Name maybe was stopped previously"
        Write-Output $response

    }

}
Export-ModuleMember -Function Stop-Docker

function Restart-Docker {

    param (
        [Parameter(Mandatory)]
        [string]$Name
    )
    if (Check-DockerExist -Name $Name) {

        docker restart $Name | Out-Null
        $response=docker ps -a --no-trunc --filter name=^/$Name$
        Write-Output $response
    } elseif ($status.Contains("non-existent")) {

        $response="CONTAINER with name $Name is not exists"
        Write-Output $response
    
    }
         

}
Export-ModuleMember -Function Restart-Docker
