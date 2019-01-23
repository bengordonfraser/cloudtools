Docker image on Alpine Linux with Google SDK and AWS CLI

#### Setup

Copy GCP service account credentials, named `svc_account.json` into the directory you're running this container from,

Put the AWS auth script into the directory you're running this container from, named `<your-script-name>.sh`, 
and execute it with: 

```
. <your-script-name>.sh
```
This adds a `cloudtools` alias into the shell which authorises with AWS using the key pair from the auth script. Calls can then be issued to any GCP or AWS command as follows. 

The GCP service account authorization happens in the `docker_entrypoint.sh` script.

#### Usage examples

```
cloudtools gsutil ls --help
```
```
cloudtools aws s3 ls 
```
```
cloudtools gcloud auth list
```

#### Example AWS and alias script
```
#!/bin/bash
export AWSREGION=<your AWS region of choice>
export AWSACCESSKEYID=<your AWS access key ID>
export AWSSECRETACCESSKEY=<your AWS secret access key>
alias cloudtools="docker run -it --rm -e AWS_DEFAULT_REGION=$AWSREGION -e AWS_ACCESS_KEY_ID=$AWSACCESSKEYID -e AWS_SECRET_ACCESS_KEY=$AWSSECRETACCESSKEY -v $(pwd):/tmp/certs bengordonfraser/cloudtools:latest"
```

