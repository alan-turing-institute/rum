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


## Authorise using the device code flow

curl -d "client_id=a462354f-fd23-4fdf-94f5-5cce5a6c27c7&scope=Bookings.Read.All" -X POST https://login.microsoftonline.com/4395f4a7-e455-4f95-8a9f-1fbaef6384f9/devicecode
