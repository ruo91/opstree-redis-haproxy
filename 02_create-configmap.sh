#!/bin/bash
NAMESPACE="redis"
oc create configmap haproxy-template \
  --from-file=conf/haproxy-template.cfg \
  -n $NAMESPACE
