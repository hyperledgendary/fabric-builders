#!/bin/bash

#
# SPDX-License-Identifier: Apache-2.0
#

#######################################
# Exit script with an error
# Globals:
#   None
# Arguments:
#   message: Optional error message
# Returns:
#   None
#######################################
function error_exit {
    echo "${1:-"Unknown Error"}" 1>&2
    exit 1
}

#######################################
# Check whether the chaincode type is supported
# Globals:
#   None
# Arguments:
#   CHAINCODE_METADATA_DIR: Location of metadata.json
#   CHAINCODE_TYPE: The required chaincode type
# Returns:
#   None
#######################################
function check_chaincode_type {
    local CHAINCODE_METADATA_DIR="$1"
    local CHAINCODE_TYPE="$2"

    if [ ! "$(jq -r .type "$CHAINCODE_METADATA_DIR/metadata.json" | tr '[:upper:]' '[:lower:]')" = "$CHAINCODE_TYPE" ]; then
        error_exit "Unsupported chaincode type: $CHAINCODE_TYPE"
    fi
}
