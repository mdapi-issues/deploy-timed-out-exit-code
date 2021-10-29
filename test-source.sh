#!/usr/bin/env bash

set +e # don't exit this test if a command fails

echo "## initiate a source:deploy and wait 1 minute"
sfdx force:source:deploy --sourcepath force-app --checkonly --wait 1
sourceDeployExitCode=$?
echo -e "exit code was: ${sourceDeployExitCode}\n"

echo "## report on the deployment using source:deploy:report and wait for 1 minute"
sfdx force:source:deploy:report --wait 1
sourceDeployReportExitCode=$?
echo -e "exit code was: ${sourceDeployReportExitCode}\n"

if [[ "${sourceDeployExitCode}" == "0" || "${sourceDeployReportExitCode}" == "0" ]]; then
    echo "The deployment timed out and at least one command didn't fail as expected"
    exit 1
fi
echo "The deployment timed out and the commands both failed as expected"
