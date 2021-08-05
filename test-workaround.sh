#!/usr/bin/env bash

set +e # don't exit this test if a command fails

tmpDir="$(mktemp -d)"
npx sfdx force:source:convert -r force-app -d "${tmpDir}"

echo "## initiate a deployment using mdapi:deploy"
deployId="$(sfdx force:mdapi:deploy --deploydir "${tmpDir}" --checkonly --wait 0 --json | tee /dev/stderr | node -pe 'JSON.parse(fs.readFileSync(0, "utf8")).result.id')"

echo "## WORKAROUND: report on the deployment using source:deploy:report and wait for 1 minute"
sfdx force:source:deploy:report -i "${deployId}" --wait 1
workaroundExitCode=$?
echo -e "exit code was: ${workaroundExitCode}\n"

if [[ "${workaroundExitCode}" == "0" ]]; then
    echo "the deployment timed out but the command exited with 0"
    exit 1
fi
