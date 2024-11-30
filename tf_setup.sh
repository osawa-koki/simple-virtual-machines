#!/bin/bash

gh secret set TF_BACKEND --body "$(cat .tfbackend)"
