terraform {
    backend "remote" {
    # The name of your Terraform Cloud organization.
    organization = "example-org-1bf7c7"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
        name = "example-workspace"
    }
    }
}