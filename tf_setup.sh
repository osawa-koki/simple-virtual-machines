#!/bin/bash

gh secret set TF_BACKEND --body "$(cat .tfbackend)"
gh secret set TF_VARS --body "$(cat terraform.tfvars)"
