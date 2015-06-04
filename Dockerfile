FROM centos:centos7

LABEL Build docker build --rm --tag goern/skydns-centos7 .

LABEL License The MIT License (MIT)
LABEL Version 2.5.0b

ENV GOPATH /Gocode
RUN mkdir /Gocode

RUN yum -y install --setopt=tsflags=nodocs golang git mercurial && \ 
    yum -y erase --setopt=clean_requirements_on_remove=true vim-minimal && \
    yum -y update && yum clean all
RUN go get --tag=2.5.0b github.com/skynetservices/skydns && \
    cd $GOPATH/src/github.com/skynetservices/skydns && \
    go build -v && \
    go install -v
RUN yum -y erase --setopt=clean_requirements_on_remove=true mercurial git golang cpp gcc glibc-devel glibc-headers binutiles golang-pkg-bin-linux-amd64 golang-pkg-linux-amd64 golang-src kernel-headers libmpc mpfr && \ 
    yum clean all

WORKDIR /Gocode/bin

EXPOSE 53 53/udp

ENTRYPOINT [ "/Gocode/bin/skydns" ]
CMD [ "--nameservers=8.8.8.8:53,8.8.4.4:53" ]
