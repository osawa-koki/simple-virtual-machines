#!/bin/bash

function color_green_echo() {
  echo -e "\e[32m$1\e[0m"
}

echo "Do you want to search config of .tfbackend? (y/n)"
read edit_tfbackend
if [ "$edit_tfbackend" = 'y' ]; then
  subscription_id=$(az account show --query id --output json | jq -r .)
  tenant_id=$(az account show --query tenantId --output json | jq -r .)
  color_green_echo "subscription_id: $subscription_id"
  color_green_echo "tenant_id: $tenant_id"
  read -p "storage_account_name: " storage_account_name
  resource_group_name=$(
      az storage account show \
      --name $storage_account_name \
      --query resourceGroup \
      --output json | jq -r .
    )
  color_green_echo "resource_group_name: $resource_group_name"
  read -p "container_name: " container_name
  echo "container_name: $container_name"
  container_exists=$(az storage container exists --name $container_name --account-name $storage_account_name --output json | jq -r .exists)
  if [ "$container_exists" = "false" ]; then
    echo "container_name: $container_name does not exist."
    read -p "Do you want to create it? (y/n)" create_container
    if [ "$create_container" = 'y' ]; then
      az storage container create --name $container_name --account-name $storage_account_name
    fi
  else
    echo "container_name: $container_name already exists."
  fi
fi

gh secret set TF_BACKEND --body "$(cat .tfbackend)"
gh secret set TF_VARS --body "$(cat terraform.tfvars)"
