#!/bin/bash

# Function to download a jar file from Confluent Maven repository
download_jar() {
    GROUP_ID=$1
    ARTIFACT_ID=$2
    VERSION=$3

    # Replace dots with slashes in groupId to match Maven path structure
    GROUP_PATH=$(echo $GROUP_ID | tr '.' '/')

    # Construct the URL for the JAR file
    JAR_URL="https://packages.confluent.io/maven/$GROUP_PATH/$ARTIFACT_ID/$VERSION/$ARTIFACT_ID-$VERSION.jar"

    echo "Downloading $ARTIFACT_ID-$VERSION.jar from Confluent Maven repository"

    # Download the JAR file
    wget $JAR_URL -P jars/

    if [ $? -eq 0 ]; then
        echo "$ARTIFACT_ID-$VERSION.jar downloaded successfully."
    else
        echo "Failed to download $ARTIFACT_ID-$VERSION.jar."
    fi
}

# Create a directory to store the jars
mkdir -p jars

# Download the dependencies from Confluent Maven repository
download_jar "io.confluent" "kafka-connect-avro-converter" "7.5.0"
download_jar "io.confluent" "kafka-connect-avro-data" "7.5.0"
download_jar "io.confluent" "kafka-avro-serializer" "7.5.0"
download_jar "io.confluent" "kafka-schema-serializer" "7.5.0"
download_jar "io.confluent.connect" "kafka-schema-converter" "7.5.0"
download_jar "io.confluent" "kafka-schema-registry-client" "7.5.0"
download_jar "io.confluent" "common-config" "7.5.0"
download_jar "io.confluent" "common-utils" "7.5.0"

echo "All dependencies downloaded."
