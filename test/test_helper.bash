#!/usr/bin/env bash

setup_script_dir() {
  src_dirname="$1"
  test_dirname="$2"

  export SCRIPT_DIR="${test_dirname}/script_dir/"

  mkdir -p "${SCRIPT_DIR}"
  cp -a "${src_dirname}/"* "${SCRIPT_DIR}"
}
