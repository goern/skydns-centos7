# skydns-centos7
This is a CentOS7 based SkyDNS container image

## requirements
You must provide the list of etcd servers by adding `-e ETCD_MACHINES='http://host-1:4001,http://host-2:4001'` to your `docker run` command.
