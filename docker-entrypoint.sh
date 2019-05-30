#!/bin/bash
set -e

gcloud auth activate-service-account --key-file=./svc_account.json

exec "$@"
