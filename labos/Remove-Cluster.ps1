# Remove-Cluster.ps1 [-ClusterName NAME]

param(
  [string]$ClusterName
)

# check if $ClusterName is not empty and delete the cluster
if ($ClusterName -ne $null) {
  Write-Host "Deleting Cluster $ClusterName"
  gcloud container clusters delete $ClusterName
}
else {
  Write-Host "Please make sure the ClusterName is not empty"
}