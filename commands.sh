#! /usr/bin/env bash
#echo project = `gcloud config get-value project` > ~/.cbtrc
#echo instance = instance1 >> ~/.cbtrc
#cbt createinstance instance1 "My bigtable" cluster1 asia-south1-a 1 HDD
#mvn archetype:generate -DgroupId=explorations.bigtable -DartifactId=bigtable101 -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false

#cbt createtable my-table
#cbt ls
#cbt createfamily my-table cf1
#cbt ls my-table
#cbt set my-table r1 cf1:c1=test-value
#cbt read my-table
#cbt deletetable my-table
mvn exec:java -Dexec.mainClass=explorations.bigtable.Client

GOOGLE_APPLICATION_CREDENTIALS=spanner-credentials.json java -jar bigtable-beam-import-1.6.0-shaded.jar export \
--runner=dataflow \
--project=project1 \
--bigtableInstanceId=instance1 \
--bigtableTableId=my-table \
--destinationPath=gs://datastore/export-path \
--tempLocation=gs://datastore/tmp-path \
--maxNumWorkers=1 \
--zone=asia-south1-a

#Table has to be present before import
#Column family has be present before import

 GOOGLE_APPLICATION_CREDENTIALS=spanner-credentials.json java -jar bigtable-beam-import-1.6.0-shaded.jar import \
--runner=dataflow \
--project=project1 \
--bigtableInstanceId=instance1 \
--bigtableTableId=my-table \
--sourcePattern='gs://datastore/export-path/part-*' \
--tempLocation=gs://datastore/tmp-path \
--maxNumWorkers=1 \
--zone=asia-south1-a
