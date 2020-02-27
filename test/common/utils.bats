#!/usr/bin/env bats

load ../test_helper

setup() {
  src_dir="${BATS_TEST_DIRNAME}/../../builders"
  testcase_dirname="$(mktemp -d)"

  setup_script_dir "${src_dir}" "${testcase_dirname}"

  source "${SCRIPT_DIR}/common/utils.sh"
}

@test "utils.sh: should exist and be executable" {
  [ -x "${SCRIPT_DIR}/common/utils.sh" ]
}

@test "utils.sh: error_exit should exit 1 with a default error message" {
  run error_exit

  echo "$output"
  [ $status -eq 1 ]
  [ "${output}" = "Unknown Error" ]
}

@test "utils.sh: error_exit should exit 1 with the provided error message" {
  run error_exit "R Tape loading error, 0:1"

  echo "$output"
  [ $status -eq 1 ]
  [ "${output}" = "R Tape loading error, 0:1" ]
}
