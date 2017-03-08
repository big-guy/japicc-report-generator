#!/bin/bash
declare OLD=$1
declare NEW=$2

gradle --no-daemon -g gradlehome wrapper --gradle-version=$OLD
./gradlew -g gradlehome resolve
# TODO: Pull from nightly
/Users/sterling/tmp/gradletest/bin/gradle -g gradlehome resolve
declare OLDJAR="gradlehome/caches/$OLD/generated-gradle-jars/gradle-api-$OLD.jar"
declare NEWJAR="gradlehome/caches/$NEW/generated-gradle-jars/gradle-api-$NEW.jar"

rm -rf compat_reports/
japi-compliance-checker -keep-internal $OLDJAR $NEWJAR
mv compat_reports compat_reports.internal
japi-compliance-checker $OLDJAR $NEWJAR
