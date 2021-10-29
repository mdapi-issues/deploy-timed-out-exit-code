#!/usr/bin/env bash

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

echo "MWE: Neither command failed with an error but both actually should fail"
