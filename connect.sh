#!/bin/bash

source .env

INSTANCE_IP_ADDRESS=$(terraform output -raw instance_ip_address)

ssh -i $SSH_PRIVATE_KEY_PATH ubuntu@${INSTANCE_IP_ADDRESS}
