#!/bin/bash
set -e

STARTUP=""
sleep 30
while [[ "$STARTUP" != *"Successfully completed initialization of host"* ]]
do
  echo "Waiting for init script to complete..."
  sleep 30
  STARTUP=$(grep "Successfully completed initialization of host" init.log)
done

echo "Waiting for 120 seconds..."
sleep 120

./run_initialization_checks.sh
bmctl create config -c anthos-gce-cluster
cp anthos-gce-cluster.yaml bmctl-workspace/anthos-gce-cluster
bmctl create cluster -c anthos-gce-cluster
