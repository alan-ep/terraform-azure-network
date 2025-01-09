# Terraform Azure Network
This is a private repository for the Network team. Once a standard is developed by the cloud migration team, we will migrate this repository to the EasyPost organization. 

# Structure
The repository is structured by environment, which is only `dev` for now. Within each environment, project names should be loosely modeled after the associated resource group name. 
For example, the project associated with `rg-epchubspoke-dev-eastus2` is named `epchubspoke`. 


```
.
├──  environments
    ├──  dev
    │    └──  epchubspoke
    └──  prod
└── modules
```