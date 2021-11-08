#!/bin/bash

export CLUSTER_ID=anthos-gce-cluster
export KUBECONFIG=$HOME/bmctl-workspace/$CLUSTER_ID/$CLUSTER_ID-kubeconfig

alias k='kubectl'
