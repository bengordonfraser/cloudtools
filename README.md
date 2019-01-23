Docker image on Alpine Linux with Google SDK and AWS CLI

#### Setup

copy GCP service account credentials, named `svc_account.json` into the directory you're running this container from,

copy AWS auth script into the directory you're running this container from, execute it with: 

```
. <your-script-name>
```
This also adds a cloudtools alias into the shell which authorises with AWS using the key pair from the auth script. Calls can then be issued to any GCP or AWS command as follows. 
The GCP service account authorization happens in the docker_entrypoint.sh script.

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


