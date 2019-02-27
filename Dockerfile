FROM alpine:latest

# Installing the AWS CLI
RUN apk --no-cache update && \
    apk --no-cache add bash  python py-pip py-setuptools ca-certificates curl groff less && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/*

# Download the Google SDK package
RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Install the Google SDK package
RUN mkdir -p /usr/local/gcloud && \
    tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz && \
    /usr/local/gcloud/google-cloud-sdk/install.sh   

# Add the Google SDK path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

# Update the gcloud components
RUN gcloud components update

# Configure the Docker entrypoint
ADD docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
