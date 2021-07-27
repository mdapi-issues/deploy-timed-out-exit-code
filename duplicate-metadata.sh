#!/usr/bin/env bash

COUNT="${COUNT:-40}"

for i in $(seq -w 2 ${COUNT}); do
    cp "force-app/main/default/layouts/Dummy01__c-Dummy01 Layout.layout-meta.xml" "force-app/main/default/layouts/Dummy${i}__c-Dummy${i} Layout.layout-meta.xml"
    mkdir -p "force-app/main/default/objects/Dummy${i}__c"
    sed -e "s/Dummy01/Dummy${i}/g" < "force-app/main/default/objects/Dummy01__c/Dummy01__c.object-meta.xml" > "force-app/main/default/objects/Dummy${i}__c/Dummy${i}__c.object-meta.xml"
    cp -r "force-app/main/default/objects/Dummy01__c/fields" "force-app/main/default/objects/Dummy${i}__c/"
done