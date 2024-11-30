#!/bin/bash

source .env

# -----

CODE_BLOCK="\`\`\`"

# -----

if [ -f .env ]; then
  echo ".env already exists."
else
  echo "Creating .env..."
  cp .env.example .env
  echo ".env created."
  echo "Please edit .env."
  read -p "Press Enter when you finish editing..."
fi
echo ""

if [ -f terraform.tfvars ]; then
  echo "terraform.tfvars already exists."
else
  echo "Creating terraform.tfvars..."
  cp terraform.tfvars.example terraform.tfvars
  echo "terraform.tfvars created."
  echo "Please edit terraform.tfvars."
  read -p "Press Enter when you finish editing..."
fi
echo ""

# -----

if [ -f "$SSH_PRIVATE_KEY_PATH" ]; then
  echo "ssh key already exists."
else
  echo "ssh key does not exist."
  echo "Do you want to create ssh key? (y/n)"
  echo ""
  echo "private key path: $SSH_PRIVATE_KEY_PATH"
  echo "public key path: $SSH_PRIVATE_KEY_PATH.pub"
  echo ""
  read -r create_ssh_key

  if [ "$create_ssh_key" = "y" ]; then
    echo "Creating ssh key..."
    ssh-keygen -t rsa -b 4096 -f $SSH_PRIVATE_KEY_PATH
    echo "ssh key created."
    echo "ssh key path (private): $SSH_PRIVATE_KEY_PATH"
    echo "ssh key path (public): $SSH_PRIVATE_KEY_PATH.pub"

    echo "Please add ssh_public_key to terraform.tfvars."
    echo ""
    echo "${CODE_BLOCK}terraform.tfvars"
    echo "..."
    tail -n 3 terraform.tfvars
    echo -e "\033[32m+ ssh_public_key = \"$(cat $SSH_PRIVATE_KEY_PATH.pub)\"\033[0m"
    echo "${CODE_BLOCK}"
    echo ""
    read -p "Press Enter when you finish editing..."
  fi
fi
echo ""

# -----

echo "Getting subscription id..."
subscription_id=$(az account show --query id --output json | jq -r .)
export SUBSCRIPTION_ID=$subscription_id
echo "Subscription id: $subscription_id"
echo ""

echo "Please add subscription_id to terraform.tfvars."
echo ""
echo "${CODE_BLOCK}terraform.tfvars"
echo "..."
tail -n 3 terraform.tfvars
echo -e "\033[32m+ subscription_id = \"$subscription_id\"\033[0m"
echo "${CODE_BLOCK}"
echo ""
read -p "Press Enter when you finish editing..."

echo "Done."
