#!/bin/bash

#
# SPDX-License-Identifier: Apache-2.0
#

function usage() {
    echo "Usage: pkgcc.sh -l <label> -t <type> [-m <META-INF directory>] <file>"
}

function error_exit {
    echo "${1:-"Unknown Error"}" 1>&2
    exit 1
}

while getopts "hl:t:m:" opt; do
    case "$opt" in
        h)
            usage
            exit 0
            ;;
        l)
            label=${OPTARG}
            ;;
        t)
            type=${OPTARG}
            ;;
        m)
            metainf=${OPTARG}
            ;;
        *)
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND-1))

file=$1

if [ -z "$label" ] || [ -z "$type" ] || [ -z "$file" ]; then
    usage
    exit 1
fi

filename=$(basename "$file")
if [ "$type" = "external" ] && [ ! "$filename" = "connection.json" ]; then
    error_exit "Invalid chaincode file $file: external chaincode requires a connection.json file"
elif [ "$type" = "prebuilt" ] && [ ! "$filename" = "prebuilt.tgz" ]; then
    # TODO check file contains a start.sh script?
    error_exit "Invalid chaincode file $file: prebuilt chaincode must be in a prebuilt.tgz file"
fi

if [ ! -d "$file" ] && [ ! -f "$file" ]; then
    error_exit "Cannot find file $file"
fi

metadir=$(basename "$metainf")
if [ -n "$metainf" ]; then
    if [ "$type" != "external" ]; then
        error_exit "The chaincode META-INF directory option is only supported for external chaincode"
    elif [ "META-INF" != "$metadir" ]; then
        error_exit "Invalid chaincode META-INF directory $metadir: directory name must be 'META-INF'"
    elif [ ! -d "$metainf" ]; then
        error_exit "Cannot find directory $metadir"
    fi
fi

prefix=$(basename "$0")
tempdir=$(mktemp -d -t "$prefix.XXXXXXXX") || error_exit "Error creating temporary directory"

if [ -n "$DEBUG" ]; then
    echo "label = $label"
    echo "type = $type"
    echo "file = $file"
    echo "tempdir = $tempdir"
    echo "metainf = $metainf"
fi

mkdir -p "$tempdir/src"
if [ -d "$file" ]; then
    cp -a "$file/"* "$tempdir/src/"
elif [ -f "$file" ]; then
    cp -a "$file" "$tempdir/src/"
fi

if [ -n "$metainf" ]; then
    cp -a "$metainf" "$tempdir/src/"
fi

mkdir -p "$tempdir/pkg"
cat << METADATA-EOF > "$tempdir/pkg/metadata.json"
{
    "type": "$type",
    "label": "$label"
}
METADATA-EOF

if [ "$type" = "external" ] || [ "$type" = "prebuilt" ]; then
    tar -C "$tempdir/src" -czf "$tempdir/pkg/code.tar.gz" .
else
    tar -C "$tempdir" -czf "$tempdir/pkg/code.tar.gz" src 
fi

tar -C "$tempdir/pkg" -czf "$label.tgz" metadata.json code.tar.gz

rm -Rf "$tempdir"
