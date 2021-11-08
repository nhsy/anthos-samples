#!/bin/bash
set -xe

export CLUSTER_ID=anthos-gce-cluster
export KUBECONFIG=$HOME/bmctl-workspace/$CLUSTER_ID/$CLUSTER_ID-kubeconfig
VERSION=v1.7.7

wget -O rook.tgz https://github.com/rook/rook/archive/refs/tags/${VERSION}.tar.gz
tar -xvf rook.tgz
mv rook-* rook
cd rook/cluster/examples/kubernetes/ceph
kubectl create -f crds.yaml -f common.yaml -f operator.yaml
sleep 5
kubectl create -f cluster.yaml
sleep 5
kubectl create -f csi/rbd/storageclass.yaml
sleep 5
kubectl patch storageclass rook-ceph-block -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
