#/bin/bash

aws s3 sync _site s3://www.insuranceexpertsgroup.com --delete  --acl public-read --cache-control max-age=300,public
