#!/bin/sh
#
# Runs tflint against code
#

# Checking if test is going to be performed against pull request or main repo
ls pull-request &>/dev/null
if [ $? -eq 0 ]
then
    echo "Evaluating pull-request"
    export TEST_DIR=pull-request
else
    echo "Evaluating infrastructure-repo"
    export TEST_DIR=infrastructure-repo
fi

set -e

cd $TEST_DIR

# "Scanning" terraform
for env in $(ls environments | grep '.tfvars')
do
    echo "****************** SCANNING $env ******************"
    tflint --error-with-issues --fast --var-file=environments/$env
done
