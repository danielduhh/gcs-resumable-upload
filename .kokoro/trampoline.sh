#!/bin/bash
# Copyright 2017 Google LLC
#
# Use of this source code is governed by an MIT-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.
# TODO: Remove this file from the template.

set -eo pipefail

# Always run the cleanup script, regardless of the success of bouncing into
# the container.
function cleanup() {
    chmod +x ${KOKORO_GFILE_DIR}/trampoline_cleanup.sh
    ${KOKORO_GFILE_DIR}/trampoline_cleanup.sh
    echo "cleanup";
}
trap cleanup EXIT

$(dirname $0)/populate-secrets.sh # Secret Manager secrets.
python3 "${KOKORO_GFILE_DIR}/trampoline_v1.py"
