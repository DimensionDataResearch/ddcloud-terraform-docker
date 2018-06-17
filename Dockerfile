FROM golang:alpine as Build

ENV TERRAFORM_VERSION=0.11.7
ENV DDCLOUD_VERSION=1.3

RUN apk add --update git bash openssh make

ENV TF_DEV=true
ENV TF_RELEASE=true

WORKDIR $GOPATH/src/github.com/hashicorp/terraform
RUN git clone https://github.com/hashicorp/terraform.git ./ && \
    git checkout v${TERRAFORM_VERSION} && \
    /bin/bash scripts/build.sh && \
    ls -l /bin
WORKDIR $GOPATH/src/github.com/DimensionDataResearch/dd-cloud-compute-terraform
RUN git clone https://github.com/DimensionDataResearch/dd-cloud-compute-terraform.git ./ && \
    git checkout release/v${DDCLOUD_VERSION} && \
    go get github.com/pkg/errors && \
    go get golang.org/x/crypto/pkcs12 && \
    go get github.com/DimensionDataResearch/go-dd-cloud-compute/compute && \
    make dev

FROM golang:alpine
COPY --from=build $GOPATH/bin/terraform /bin 
COPY --from=build $GOPATH/src/github.com/DimensionDataResearch/dd-cloud-compute-terraform/_bin/terraform-provider-ddcloud /bin

WORKDIR $GOPATH


ENTRYPOINT ["terraform"]