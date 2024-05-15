$INSTANCE_NAME="win-server-with-docker"
$PROJECT_NAME="boxwood-weaver-415718"
$ZONE="europe-west1-b"
$MACHINE_TYPE="e2-medium"
$SOURCE_IMAGE="win-server-docker-machine-image"

if ($args.count -eq 0) {
    gcloud compute instances create $INSTANCE_NAME `
        --project=$PROJECT_NAME `
        --zone=$ZONE `
        --machine-type=$MACHINE_TYP `
        --metadata="windows-startup-script-ps1=docker run -d -p 80:80 emptier1359/iis-site-windows" `
        --tags=http-server `
        --source-machine-image=$SOURCE_IMAGE

}
elseif ($args.count -eq 1 -and $args[0] -eq "-delete") {
    gcloud compute instances delete $INSTANCE_NAME
}
else 
{
    Write-Host "GEBRUIK: deploy.ps1 [-delete]"
}

