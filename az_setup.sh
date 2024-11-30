#!/bin/bash

az ad sp create-for-rbac \
  --name "github-actions-terraform" \
  --role Contributor \
  --scopes /subscriptions/${SUBSCRIPTION_ID} \
  --only-show-errors \
  --output json | jq -r '.appId, .password, .tenant' | {
    read client_id
    read client_secret
    read tenant_id

    echo "export ARM_SUBSCRIPTION_ID=${SUBSCRIPTION_ID}"
    echo "export ARM_TENANT_ID=${tenant_id}"
    echo "export ARM_CLIENT_ID=${client_id}"
    echo "export ARM_CLIENT_SECRET=${client_secret}"

    echo "az login \\"
    echo "  --service-principal \\"
    echo "  --username ${client_id} \\"
    echo "  --password ${client_secret} \\"
    echo "  --tenant ${tenant_id}"

    echo "Do you want to set these secrets in GitHub repository settings? (y/n)"
    read answer
    if [ "$answer" = "y" ]; then
      gh secret set ARM_SUBSCRIPTION_ID --body "${SUBSCRIPTION_ID}"
      gh secret set ARM_CLIENT_ID --body "${client_id}"
      gh secret set ARM_CLIENT_SECRET --body "${client_secret}"
      gh secret set ARM_TENANT_ID --body "${tenant_id}"
    fi
}
