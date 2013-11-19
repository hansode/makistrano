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
  function ssh() { echo ssh ${@}; }
  function git() { echo git ${@}; }
}

function test_makistrano_cli_namespace_test() {
  local task
  for task in whoami uptime; do
    makistrano_cli solo test:${task} >/dev/null
    assertEquals 0 ${?}
  done
}

function test_makistrano_cli_namespace_deploy() {
  local task
  for task in setup update; do
    makistrano_cli solo deploy:${task} >/dev/null
    assertEquals 0 ${?}
  done
}

function test_makistrano_cli_namespace_server() {
  local task
  for task in start stop restart status; do
    makistrano_cli solo server:${task} >/dev/null
    assertEquals 0 ${?}
  done
}

function test_makistrano_cli_task_whoami() {
  makistrano_cli solo whoami >/dev/null
  assertEquals 0 ${?}
}

function test_makistrano_cli_task_date() {
  makistrano_cli solo date >/dev/null
  assertEquals 0 ${?}
}

function test_makistrano_cli_undefined_namespace() {
  local task
  for task in setup update; do
    makistrano_cli undef foo:${task} 2>/dev/null
    assertNotEquals 0 ${?}
  done
}

function test_makistrano_cli_defined_namespace_task_with_empty_nodes() {
  local task
  makistrano_cli empty server:status 2>/dev/null
  assertEquals 0 ${?}
}


## shunit2

. ${shunit2_file}
