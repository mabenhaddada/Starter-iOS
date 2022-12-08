#!/bin/sh
set -x # debug
set -e
set -u
set -o pipefail

${PODS_ROOT}/SwiftLint/swiftlint --config ${SOURCE_ROOT}/Tools/Configs/swiftlint.yml --quiet
