#! /bin/sh
# run UITests

set -e

xcodebuild -project Wikipedia.xcodeproj -scheme UITests -sdk iphonesimulator -destination 'platform=iOS Simulator,name=iPhone 12 Pro,OS=14.4' test | xcpretty --report html --output Reports/uitestReport.html
