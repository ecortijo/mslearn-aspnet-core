#!/bin/bash

# Color theming
if [ -f ~/clouddrive/aspnet-learn/setup/theme.sh ]
then
  . <(cat ~/clouddrive/aspnet-learn/setup/theme.sh)
fi

if [ -f ~/clouddrive/aspnet-learn/create-aks-exports.txt ]
then
  eval $(cat ~/clouddrive/aspnet-learn/create-aks-exports.txt)
fi

if [ -f ~/clouddrive/aspnet-learn/create-acr-exports.txt ]
then
  eval $(cat ~/clouddrive/aspnet-learn/create-acr-exports.txt)
fi

if [ -z "$ESHOP_REGISTRY" ]
then
    echo "ERROR: The ESHOP_REGISTRY environment variable is not defined."
    exit 1
fi

if [ -z "$ESHOP_LBIP" ]
then
    echo "ERROR: The ESHOP_LBIP environment variable is not defined."
    exit 1
fi

echo "Updating existing AKS deployment..."

pushd ~/clouddrive/aspnet-learn/src/deploy/k8s

./deploy-application.sh --charts webspa,webstatus,webshoppingagg,coupon

popd

echo "Done updating existing AKS deployment!"
