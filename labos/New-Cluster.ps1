# New-Cluster.ps1 [-LinuxNodes COUNT] [-WindowsNodes COUNT] [-ClusterName NAME] [-Yaml YAML_FILE]

# gcloud container clusters create windows-cluster --enable-ip-alias --num-nodes=1

# gcloud container node-pools create windows-pool --cluster=windows-cluster --image-type=WINDOWS_LTSC_CONTAINERD --no-enable-autoupgrade --machine-type=n1-standard-2

# kubectl apply -f iis-site-windows-v2.yaml

param(
  [int]$LinuxNodes,  # Optional named parameter
  [int]$WindowsNodes, # Optional switch parameter
  [string]$ClusterName,
  [string]$Yaml
)

# check if $LinuxNodes is bigger than 0
if ($LinuxNodes -gt 0) {
  Write-Host "Creating Linux Cluster"
  # create linux cluster
  # check if $Yaml parameter is present
  gcloud container clusters create $ClusterName --enable-ip-alias --num-nodes=$LinuxNodes

  if ($WindowsNodes -gt 0) {
  Write-Host "Creating Windows Cluster"
  # create windows cluster
  gcloud container node-pools create windows-pool --cluster=$ClusterName --image-type=WINDOWS_LTSC_CONTAINERD --no-enable-autoupgrade --machine-type=n1-standard-2
  }

  if ($PSBoundParameters.ContainsKey('Yaml')) {
    # apply yaml file
    Write-Host "Applying Yaml file $Yaml"
    kubectl apply -f $Yaml
  }
  else {
    Write-Host "No YAML file specified"
  }

}
else {
  Write-Host "Please make sure the amount of Linux nodes is bigger than 0"
}


# function CheckNodesType {
#     param (
#         [int]$LinuxNodes,
#         [int]$WindowsNodes,
#         [string]$ClusterType
#     )

#     if ($LinuxNodes -ne 0 -and $WindowsNodes -eq 0) {
#         $ClusterType = "Linux"
        
#     }    
#     if ($WindowsNodes-ne 0 -and $LinuxNodes -eq 0) {
#         $ClusterType = "Windows"
#     }

#     return $ClusterType
# }


# function StartClusterBasedOnClusterType {   

    

#     if ($ClusterType -eq "Windows") {
#         Write-Host "Creating Windows Cluster"
    
        
        
#         if ($Yaml -ne $null) {
#             ApplyYaml -Yaml $Yaml
#         }
#     }

# }

# function ApplyYaml {
#     param (
#         [string]$Yaml
#     )

#     if ($PSBoundParameters.ContainsKey('Yaml')) {
#         Write-Host "Applying Yaml file %Yaml"
#         kubectl apply -f $Yaml
#     } else
#     {
#         Write-Host "Yaml parameter is not present"
#     }
# }
    
# $ClusterType = CheckNodesType -LinuxNodes $LinuxNodes -WindowsNodes $WindowsNodes
# StartClusterBasedOnClusterType -ClusterType $ClusterType -ClusterName $ClusterName -Yaml $Yaml
