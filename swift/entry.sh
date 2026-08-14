#!/usr/bin/env bash
export PROJ_ROOT=$(cd "$(dirname -- "$0")" && pwd -P)

function format(){
    swift-format -i ${PROJ_ROOT}/playground/*.swift
}

function run() {
    local fileName=$1
    swift-format -i ${PROJ_ROOT}/"${fileName}"
    swift ${PROJ_ROOT}/"${fileName}"
}

function main() {
    local funcName="$1"
    shift
    "$funcName" "$@"
}
main "$@"
