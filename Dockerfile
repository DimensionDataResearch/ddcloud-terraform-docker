FROM hashicorp/terraform:light

RUN wget https://github.com/DimensionDataResearch/dd-cloud-compute-terraform/releases/download/v1.3.8/terraform-provider-ddcloud.v1.3.8.linux-amd64.zip  -O /tmp/terraform-provider-ddcloud.v1.3.8.linux-amd64.zip

RUN unzip /tmp/terraform-provider-ddcloud.v1.3.8.linux-amd64.zip -d /tmp
RUN ls -l /tmp
RUN mv /tmp/terraform-provider-ddcloud /bin
RUN rm /tmp/terraform-provider-ddcloud.v1.3.8.linux-amd64.zip

