﻿<#
.SYNOPSIS
    Remove GoogleDrive Item permission
.DESCRIPTION
    Remove GoogleDrive Item permission
.PARAMETER ID
    File ID to return permissions from
.PARAMETER PermissionID
    Permission ID to remove
.PARAMETER UseDomainAdminAccess
    Issue the request as a domain administrator;
    The requester will be granted access if the file ID parameter refers to a shared drive and
    the requester is an administrator of the domain to which the shared drive belongs.
.PARAMETER AccessToken
    Access Token for request
.EXAMPLE
    Remove-GDriveItemPermission -AccessToken $access_token -ID '0BAjkl4cBDNVpVbB5nGhKQ195aU0' -PermissionID 01234567890123456789
.OUTPUTS
    Json with item permission as PSObject
.NOTES
    Author: Max Kozlov
.LINK
    Get-GDriveItemPermissionList
    Get-GDriveItemPermission
    Add-GDriveItemPermission
    Set-GDriveItemPermission
    https://developers.google.com/drive/api/v3/reference/permissions/delete
#>
function Remove-GDriveItemPermission {
[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)]
    [string]$ID,

    [Parameter(Mandatory, Position=1)]
    [string]$PermissionID,

    [switch]$UseDomainAdminAccess,

    [Parameter(Mandatory)]
    [string]$AccessToken
)
    $Headers = @{
        "Authorization" = "Bearer $AccessToken"
        "Content-type"  = "application/json"
    }
    $Params = New-Object System.Collections.ArrayList
    # Always return all properties.
    [void]$Params.Add('fields=*')
    if ($UseDomainAdminAccess) {
        [void]$Params.Add('useDomainAdminAccess=true')
    }
    $Uri = '{0}{1}/permissions/{2}?supportsAllDrives=true&{3}' -f $GDriveUri, $ID, $PermissionID, ($Params -join '&')
    Invoke-RestMethod -Uri $Uri -Method Delete -Headers $Headers @GDriveProxySettings
}