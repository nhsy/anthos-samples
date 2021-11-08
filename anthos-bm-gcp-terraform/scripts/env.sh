#!/bin/bash

export GCP_PROJECT_ID=$(jq -r '.project_id' ./terraform.tfvars.json)
export GCP_REGION=$(jq -r '.region' ./terraform.tfvars.json)
export GCP_ZONE=$(jq -r '.zone' ./terraform.tfvars.json)

export GOOGLE_APPLICATION_CREDENTIALS=$PWD/scripts/anthos-baremetal-321112-363f0461bae6.json

account=$(gcloud config get-value core/account 2> /dev/null)
project=$(gcloud config get-value core/project 2> /dev/null)
region=$(gcloud config get-value compute/region 2> /dev/null)
zone=$(gcloud config get-value compute/zone 2> /dev/null)

if [[ -z "$account" ]]; then
  gcloud auth activate-service-account --key-file=$GOOGLE_APPLICATION_CREDENTIALS
fi

if [[ "$project" != "$GCP_PROJECT_ID" ]]; then
  gcloud config set project $GCP_PROJECT_ID
fi

if [[ "$region" != "$GCP_REGION" ]]; then
  gcloud config set compute/region $GCP_REGION
fi


if [[ "$zone" != "$GCP_ZONE" ]]; then
  gcloud config set compute/zone $GCP_ZONE
fi


gcloud config list

echo
echo "Environment variables:"
env | grep "GCP_"
env | grep "GOOGLE_"