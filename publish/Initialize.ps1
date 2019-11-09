﻿Function UpdateLaunchJson {
    Param(
        [string] $Name,
        [string] $Server
    )
    
    $launchSettings = [ordered]@{ "type" = "al";
                                  "request" = "launch";
                                  "name" = "$Name"; 
                                  "server" = "$Server";
                                  "serverInstance" = "NAV"; 
                                  "tenant" = ""; 
                                  "authentication" =  "UserPassword" }
    
    $settings = (Get-Content (Join-Path $PSScriptRoot "settings.json") | ConvertFrom-Json)
    
    if ($settings.PSObject.Properties.name -eq "startupObjectId") {
        $launchSettings += @{ "startupObjectId" = $settings.startupObjectId }
    }
    if ($settings.PSObject.Properties.name -eq "startupObjectType") {
        $launchSettings += @{ "startupObjectType" = $settings.startupObjectType }
    }
    if ($settings.PSObject.Properties.name -eq "breakOnError") {
        $launchSettings += @{ "breakOnError" = $settings.breakOnError }
    }
    
    Get-ChildItem $PSScriptRoot -Directory | ForEach-Object {
        $folder = $_.FullName
        $launchJsonFile = Join-Path $folder ".vscode\launch.json"
        if (Test-Path $launchJsonFile) {
            Write-Host "Modifying $launchJsonFile"
            $launchJson = Get-Content $LaunchJsonFile | ConvertFrom-Json
            $launchJson.configurations = @($launchJson.configurations | Where-Object { $_.name -ne $launchsettings.name })
            $launchJson.configurations += $launchSettings
            $launchJson | ConvertTo-Json -Depth 10 | Set-Content $launchJsonFile
        }
    }
}

$ErrorActionPreference = "Stop"
$ScriptRoot = $PSScriptRoot

$settings = (Get-Content (Join-Path $ScriptRoot "settings.json") | ConvertFrom-Json)

$defaultVersion = $settings.versions[0].version
$version = Read-Host ("Select Version (" +(($settings.versions | ForEach-Object { $_.version }) -join ", ") + ") (default $defaultVersion)")
if (!($version)) {
    $version = $defaultVersion
}

$defaultProfile = $settings.profiles | Where-Object { $_.profile -eq $env:USERNAME }
if (!($defaultProfile)) {
    $defaultProfile = $settings.profiles | Where-Object { $_.profile -eq "default" }
}
if ($defaultProfile) {
    $profile = $defaultProfile.profile
} else {
    $defaultProfile = $settings.profiles[0]
    $profile = Read-Host ("Select profile (" +(($settings.profiles | ForEach-Object { $_.profile }) -join ", ") + ") (default $($defaultProfile.profile))")
}

$imageversion = $settings.versions | Where-Object { $_.version -eq $version }
if (!($imageversion)) {
    throw "No version for $version in settings.json"
}

$azureprofile = $settings.profiles | Where-Object { $_.profile -eq $profile }
if (!($azureprofile)) {
    throw "No profile for $profile in settings.json"
}

Import-Module -Name "AzureRM.Resources"
Import-Module -Name "AzureRM.Compute"

try {
    if ((Get-AzureRmContext).Subscription.Id -ne $azureprofile.subscriptionId) {
        Set-AzureRmContext -SubscriptionID $azureprofile.subscriptionId
    }
} catch {
    Add-AzureRmAccount -Environment $azureprofile.environment
    Set-AzureRmContext -SubscriptionID $azureprofile.subscriptionId
}

$licenseFileSecret = Get-AzureKeyVaultSecret -VaultName $azureprofile.keyVault -Name "LicenseFile"
$CodeSignPfxFileSecret = Get-AzureKeyVaultSecret -VaultName $azureprofile.keyVault -Name "CodeSignPfxFile"
$CodeSignPfxPasswordSecret = Get-AzureKeyVaultSecret -VaultName $azureprofile.keyVault -Name "CodeSignPfxPassword"
$usernameSecret = Get-AzureKeyVaultSecret -VaultName $azureprofile.keyVault -Name "Username"
$passwordSecret = Get-AzureKeyVaultSecret -VaultName $azureprofile.keyVault -Name "Password"

if (($usernameSecret) -and ($passwordSecret)) {
    $credential = New-Object System.Management.Automation.PSCredential($usernameSecret.SecretValueText, $passwordSecret.SecretValue)
} else {
    throw "Username and Password secrets should be set in the Azure KeyVault"
}

if (!($licenseFileSecret)) {
    throw "License File secret should be set in the Azure KeyVault"
}
