#!/bin/bash

# Function to download a jar file from a Maven repository
download_jar() {
    REPO_URL=$1
    GROUP_ID=$2
    ARTIFACT_ID=$3
    VERSION=$4

    # Replace dots with slashes in groupId to match Maven path structure
    GROUP_PATH=$(echo $GROUP_ID | tr '.' '/')

    # Construct the URL for the JAR file
    JAR_URL="$REPO_URL/$GROUP_PATH/$ARTIFACT_ID/$VERSION/$ARTIFACT_ID-$VERSION.jar"

    echo "Downloading $ARTIFACT_ID-$VERSION.jar from $REPO_URL"

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

# Base URLs for the repositories
CONFLUENT_REPO="https://packages.confluent.io/maven"
MAVEN_CENTRAL="https://repo1.maven.org/maven2"

# Download the dependencies from Confluent Maven repository
download_jar $CONFLUENT_REPO "io.confluent" "kafka-connect-avro-converter" "7.5.0"
download_jar $CONFLUENT_REPO "io.confluent" "kafka-connect-avro-data" "7.5.0"
download_jar $CONFLUENT_REPO "io.confluent" "kafka-avro-serializer" "7.5.0"
download_jar $CONFLUENT_REPO "io.confluent" "kafka-schema-serializer" "7.5.0"
download_jar $CONFLUENT_REPO "io.confluent" "kafka-schema-converter" "7.5.0"
download_jar $CONFLUENT_REPO "io.confluent" "kafka-schema-registry-client" "7.5.0"
download_jar $CONFLUENT_REPO "io.confluent" "common-config" "7.5.0"
download_jar $CONFLUENT_REPO "io.confluent" "common-utils" "7.5.0"

# Download the additional dependencies from Maven Central
download_jar $MAVEN_CENTRAL "org.apache.avro" "avro" "1.11.3"
download_jar $MAVEN_CENTRAL "org.apache.commons" "commons-compress" "1.27.1"
download_jar $MAVEN_CENTRAL "com.google.guava" "failureaccess" "1.0.2"
download_jar $MAVEN_CENTRAL "com.google.guava" "guava" "33.3.0-jre"
download_jar $MAVEN_CENTRAL "com.eclipsesource.minimal-json" "minimal-json" "0.9.5"
download_jar $MAVEN_CENTRAL "com.google.re2j" "re2j" "1.7"
download_jar $MAVEN_CENTRAL "org.slf4j" "slf4j-api" "2.0.16"
download_jar $MAVEN_CENTRAL "org.yaml" "snakeyaml" "2.2"
download_jar $MAVEN_CENTRAL "io.swagger.core.v3" "swagger-annotations" "2.2.22"
download_jar $MAVEN_CENTRAL "com.fasterxml.jackson.core" "jackson-databind" "2.17.2"
download_jar $MAVEN_CENTRAL "com.fasterxml.jackson.core" "jackson-core" "2.17.2"
download_jar $MAVEN_CENTRAL "com.fasterxml.jackson.core" "jackson-annotations" "2.17.2"
download_jar $MAVEN_CENTRAL "com.fasterxml.jackson.dataformat" "jackson-dataformat-csv" "2.17.2"
download_jar $MAVEN_CENTRAL "io.confluent" "logredactor" "1.0.12"
download_jar $MAVEN_CENTRAL "io.confluent" "logredactor-metrics" "1.0.12"

echo "All dependencies downloaded."
