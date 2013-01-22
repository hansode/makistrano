# -*-Shell-script-*-
#
# requires:
#   bash
#

## system variables

readonly abs_dirname=$(cd ${BASH_SOURCE[0]%/*} && pwd)
readonly shunit2_file=${abs_dirname}/../../shunit2

## include files

. ${abs_dirname}/../../../functions/makistrano.sh

## group variables

makistranofile_path=${abs_dirname}/../../../examples/Makistranofile

## group functions

config=${makistranofile_path}
