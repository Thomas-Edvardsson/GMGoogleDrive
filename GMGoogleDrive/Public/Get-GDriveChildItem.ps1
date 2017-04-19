﻿<#
.SYNOPSIS
    Search GoogleDriver for items in selected ParentID
.DESCRIPTION
    Search GoogleDriver for items in selected ParentID
.PARAMETER ParentID
    Folder ID in which item will be searched
.PARAMETER AllResults
    Collect all results in one output
.PARAMETER NextPageToken
    Supply NextPage Token from Previous paged search
.PARAMETER PageSize
    Set Page Size for paged search
.PARAMETER OrderBy
    Set output order
.PARAMETER AccessToken
    Access Token for request
.EXAMPLE
    Get-GDriveItem -AccessToken $access_token -ParentID 'root'
.OUTPUTS
    Json search result with items metadata as PSObject
.NOTES
    Author: Max Kozlov
.LINK
    Find-GDriveItem
#>
function Get-GDriveChildItem {
[CmdletBinding(DefaultParameterSetName='Next')]
param(
    [Parameter(Position=0)]
    [string]$ParentID,

    [Parameter(ParameterSetName='All')]
    [switch]$AllResults,

    [Parameter(ParameterSetName='Next')]
    [string]$NextPageToken,

    [ValidateSet(    'createdTime', 'folder', 'modifiedByMeTime', 'modifiedTime', 'name', 'quotaBytesUsed', 'recency',
                    'sharedWithMeTime', 'starred', 'viewedByMeTime',
                    'createdTime desc', 'folder desc', 'modifiedByMeTime desc', 'modifiedTime desc', 'name desc', 'quotaBytesUsed desc', 'recency desc',
                    'sharedWithMeTime desc', 'starred desc', 'viewedByMeTime desc'
    )]
    [string[]]$OrderBy,

    [Parameter(Mandatory)]
    [string]$AccessToken
)
    if ($PSBoundParameters.ContainsKey('ParentID')) {
        $PSBoundParameters['Query'] = "'$ParentID'+in+parents"
        $PSBoundParameters.Remove('ParentID')
    }
    else {
        $PSBoundParameters['Query'] = ''
    }
    Find-GDriveItem @PSBoundParameters
}
