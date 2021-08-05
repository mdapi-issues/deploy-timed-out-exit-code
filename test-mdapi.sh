#!/usr/bin/env bash

set +e # don't exit this test if a command fails

tmpDir="$(mktemp -d)"
npx sfdx force:source:convert -r force-app -d "${tmpDir}"

echo "## initiate a deployment using mdapi:deploy and wait for 1 minute"
sfdx force:mdapi:deploy --deploydir "${tmpDir}" --checkonly --wait 1
mdapiDeployExitCode=$?
echo -e "exit code was: ${mdapiDeployExitCode}\n"

echo "## report on the deployment using mdapi:deploy:report and wait for 1 minute"
sfdx force:mdapi:deploy:report --wait 1
mdapiDeployReportExitCode=$?
echo -e "exit code was: ${mdapiDeployReportExitCode}\n"

if [[ "${mdapiDeployExitCode}" == "0" || "${mdapiDeployReportExitCode}" == "0" ]]; then
    echo "the deployment timed out but the command exited with 0"
    exit 1
fi
