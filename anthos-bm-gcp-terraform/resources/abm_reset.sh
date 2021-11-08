#!/bin/bash
set -xe

export CLUSTER_ID=anthos-gce-cluster
export KUBECONFIG=$HOME/bmctl-workspace/$CLUSTER_ID/$CLUSTER_ID-kubeconfig

bmctl reset --cluster $CLUSTER_ID
