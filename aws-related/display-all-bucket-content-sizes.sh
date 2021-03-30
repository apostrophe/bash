#!/bin/bash
#
# Very simple script to get the size of each bucket in your account
#
# Below command pulls all the buckets in your account
#
# 	$ aws s3 ls --recursive
#
# and this displays the total size of all objects in that bucket:
#
# 	$ aws s3 ls s3://$bucket --recursive --human-readable --summarize | tail -2
#
#

for bucket in $(aws s3 ls --recursive | awk '{print $3}')
do
	echo "bucket $bucket: `aws s3 ls s3://$bucket --recursive --human-readable --summarize | tail -2`"
done

# 
# To remove all objects in a bucket:
# 
# 	$ aws s3 rm s3://<bucket name> --recursive | less 
# 



