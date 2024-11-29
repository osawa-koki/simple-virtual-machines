#!/bin/bash

source .env

if [ ! -f terraform.tfvars ]; then
  echo "Creating terraform.tfvars..."
  cp terraform.tfvars.example terraform.tfvars
  echo "terraform.tfvars created."
  echo "Please edit terraform.tfvars."
else
  echo "terraform.tfvars already exists."
fi
echo ""

echo "Generate ssh key? (y/n)"
read -r generate_ssh_key

if [ "$generate_ssh_key" = "y" ]; then
  echo "Creating ssh key..."
  ssh-keygen -t rsa -b 4096 -f $SSH_PRIVATE_KEY_PATH
  echo "ssh key generated."

  echo "ssh key path (private): $SSH_PRIVATE_KEY_PATH"
  echo "ssh key path (public): $SSH_PRIVATE_KEY_PATH.pub"

  echo "Do you want to write ssh key path to terraform.tfvars? (y/n)"
  read -r write_ssh_key_path

  already_exists=$([ -f "$SSH_PRIVATE_KEY_PATH" ] && echo 1 || echo 0)

  if [ "$write_ssh_key_path" = "y" ] && [ "$already_exists" = "0" ]; then
    echo "Writing ssh key path to terraform.tfvars..."
    echo "ssh_public_key_path = \"$SSH_PRIVATE_KEY_PATH.pub\"" >> terraform.tfvars
    echo "wrote ssh key path to terraform.tfvars."
  elif [ "$write_ssh_key_path" = "y" ] && [ "$already_exists" = "1" ]; then
    echo "ssh key already exists."
    echo "Cannot overwrite existing ssh key path."
  else
    echo "Skip writing ssh key path."
  fi
  echo ""
fi
echo ""

echo "Getting subscription id..."
subscription_id=$(az account show --query id --output json | jq -r .)
echo "Subscription id: $subscription_id"
echo ""

echo "Do you want to write subscription_id to terraform.tfvars? (y/n)"
read -r write_subscription_id

if [ "$write_subscription_id" = "y" ]; then
  echo "Writing subscription_id to terraform.tfvars..."
  echo "subscription_id = \"$subscription_id\"" >> terraform.tfvars
  echo "wrote subscription_id to terraform.tfvars."
else
  echo "Skip writing subscription_id."
fi
echo ""

echo "Done."
