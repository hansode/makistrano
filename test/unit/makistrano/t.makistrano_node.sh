#!/bin/bash
#
# requires:
#   bash
#

## include files

. $(cd ${BASH_SOURCE[0]%/*} && pwd)/helper_shunit2.sh

## variables

## functions

function setUp() {
  function task_defined() { :; }
}

function test_makistrano_node() {
  makistrano_node node defined
  assertEquals 0 ${?}
}

function test_makistrano_node_no_opts() {
  makistrano_node 2>/dev/null
  assertNotEquals 0 ${?}
}

function test_makistrano_node_undefined_task() {
  makistrano_node node undefined 2>/dev/null
  assertNotEquals 0 ${?}
}


## shunit2

. ${shunit2_file}
