#!/bin/bash
#
# requires:
#   bash
#

## include files

. $(cd ${BASH_SOURCE[0]%/*} && pwd)/helper_shunit2.sh

## variables

## functions

function test_makistrano_load_config_file_exists() {
  makistrano_load_config ${makifile_path} >/dev/null
  assertEquals 0 ${?}
}

function test_makistrano_load_config_file_not_found() {
  makistrano_load_config ${makifile_path}.${$} >/dev/null 2>&1
  assertNotEquals 0 ${?}
}

## shunit2

. ${shunit2_file}
