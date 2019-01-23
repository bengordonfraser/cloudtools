## Docker image with Google SDK and AWS CLI on Alpine Linux 
****
#### Setup

Create a GCP service account with an appropriate role granted for access to GCP resources as you see fit. Save the credential `.json`

Create an IAM user in AWS with an appropriate role granted for access to AWS resources as you see fit. Record the `AWS_ACCESS_KEY_ID` and the `AWS_SECRET_ACCESS_KEY`. Use these to create a script file '<your-script-name>.sh' copying the example below.

Copy the GCP service account credential file, named `svc_account.json` into the directory you're running this container from.
The GCP service account authorization happens at runtime in the `docker_entrypoint.sh` script.

Put your AWS auth script into the directory you're running this container from, named `<your-script-name>.sh`, 
and execute it with: 

```
. <your-script-name>.sh
```
This adds the `cloudtools` alias for `docker run` into the shell, which authorises with AWS using the key pair exported as environment variables in the auth script. Calls can then be issued to any GCP or AWS command as follows. 

****
#### Usage examples

```
cloudtools gcloud --help
```
```
cloudtools gcloud auth list
```
```
cloudtools gsutil ls gs://<your GCP bucket>
```
```
cloudtools gsutil rsync -r gs://<your GCP bucket> s3://<your AWS bucket>
```
```
cloudtools aws help
```
```
cloudtools aws s3 ls 
```
****
#### Example AWS auth and alias script
```javascript
#!/bin/bash
export AWSREGION=<your AWS region of choice>
export AWSACCESSKEYID=<your AWS_ACCESS_KEY_ID>
export AWSSECRETACCESSKEY=<your AWS_SECRET_ACCESS_KEY>
alias cloudtools="docker run -it --rm \
    -e AWS_DEFAULT_REGION=$AWSREGION \
    -e AWS_ACCESS_KEY_ID=$AWSACCESSKEYID \
    -e AWS_SECRET_ACCESS_KEY=$AWSSECRETACCESSKEY \
    -v $(pwd):/tmp/certs \
    bengordonfraser/cloudtools:latest"
```

