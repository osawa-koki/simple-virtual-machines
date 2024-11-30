#!/bin/bash

json_response=$(az ad sp create-for-rbac \
  --name "github-actions-terraform" \
  --role Contributor \
  --scopes /subscriptions/${SUBSCRIPTION_ID} \
  --only-show-errors \
  --output json)

client_id=$(echo "$json_response" | jq -r '.appId')
client_secret=$(echo "$json_response" | jq -r '.password')
tenant_id=$(echo "$json_response" | jq -r '.tenant')

echo "subscription_id: $SUBSCRIPTION_ID"
echo "client_id: $client_id"
echo "client_secret: $client_secret"
echo "tenant_id: $tenant_id"

export ARM_SUBSCRIPTION_ID=${SUBSCRIPTION_ID}
export ARM_TENANT_ID=${tenant_id}
export ARM_CLIENT_ID=${client_id}
export ARM_CLIENT_SECRET=${client_secret}

echo "Do you want to set these secrets in GitHub repository settings? (y/n)"
read answer
if [ "$answer" = "y" ]; then
  gh secret set ARM_SUBSCRIPTION_ID --body "${SUBSCRIPTION_ID}"
  gh secret set ARM_CLIENT_ID --body "${client_id}"
  gh secret set ARM_CLIENT_SECRET --body "${client_secret}"
  gh secret set ARM_TENANT_ID --body "${tenant_id}"
fi
