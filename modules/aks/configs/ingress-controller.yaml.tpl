controller:
  nodeSelector:
    kubernetes.io/os: linux
  service:
    loadBalancerIP: ${public_ip}
    externalTrafficPolicy: Local
    annotations:
      service.kubernetes.io/azure-load-balancer-health-probe-request-path: /livez
