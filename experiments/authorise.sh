#!/bin/sh

## ==== FAILS

## Get an authorisation token from Azure using the authorisation code flow


curl https://login.microsoftonline.com/4395f4a7-e455-4f95-8a9f-1fbaef6384f9/oauth2/v2.0/authorize?client_id=a462354f-fd23-4fdf-94f5-5cce5a6c27c7&response_type=code&redirect_uri=https%3A%2F%2Flogin.microsoftonline.com%2Fcommon%2Foauth2%2Fnativeclient&response_mode=query&scope=Calendars.Read

## Notes

## See here for Microsoft Graph documentation:
## https://docs.microsoft.com/en-us/graph/

## See here for useful information about this specific app in the Turing AD:
## https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationMenuBlade/Overview/appId/a462354f-fd23-4fdf-94f5-5cce5a6c27c7/objectId/a8270fdf-7795-4d94-a178-1755bf8613bf/isMSAApp/

## 4395f4a7-e455-4f95-8a9f-1fbaef6384f9 is the GUID for our AD "tenant"
## A "tenant" is (I believe) Microsoft's name for an instance of AD.


## ==== SUCCEEDS!

## Authorise using the device code flow
## Note the Microsoft's documentation lies to some extent: the URL is as below, not ../devicecode as on
## https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-device-code

## Ask user to sign in

curl -v -d 'client_id=a462354f-fd23-4fdf-94f5-5cce5a6c27c7&scope=Bookings.Read.All%20offline_access' https://login.microsoftonline.com/4395f4a7-e455-4f95-8a9f-1fbaef6384f9/oauth2/v2.0/devicecode

## Get token (replace device_code with the appropriate value!)

curl -v -d 'client_id=a462354f-fd23-4fdf-94f5-5cce5a6c27c7&grant_type=urn:ietf:params:oauth:grant-type:device_code&device_code=DAQABAAEAAADCoMpjJXrxTq9VG9te-7FXwE9GoOxztnD8UJUpEehBBcUWbWa-35cnHYrQ0xgLy2QCb_eLCBwRRopHeV-09Ppo6GCAsOOAL2Zf8T1k2yrWzMnrsDYzB0pwg-AnYVao4RVHo-Gb_SuzA-8MMo1-a-Yso3lMTDgWgCJn71PkSSWv0CAA' https://login.microsoftonline.com/4395f4a7-e455-4f95-8a9f-1fbaef6384f9/oauth2/v2.0/token


## ==== GET SOME DATA

