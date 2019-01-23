FROM alpine:latest

# Install the AWS CLI
RUN apk --no-cache update && \
    apk --no-cache add bash  python py-pip py-setuptools ca-certificates curl groff less && \
    pip --no-cache-dir install --upgrade pip awscli && \
    rm -rf /var/cache/apk/* 

# Downloading the Google SDK package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the Google SDK package
RUN mkdir -p /usr/local/gcloud && \
    tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz && \
    /usr/local/gcloud/google-cloud-sdk/install.sh   

# Adding the Google SDK path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Updating the gcloud components
RUN gcloud components update

ADD docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
