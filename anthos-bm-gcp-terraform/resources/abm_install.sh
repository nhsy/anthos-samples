#!/bin/bash
set -xe

./run_initialization_checks.sh
bmctl create config -c anthos-gce-cluster
cp anthos-gce-cluster.yaml bmctl-workspace/anthos-gce-cluster
bmctl create cluster -c anthos-gce-cluster
