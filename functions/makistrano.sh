# -*-Shell-script-*-
#
# description:
#
# requires:
#  bash
#

function makistrano_node() {
  local node=$1 task=$2; shift; shift
  local args="$*"
  [[ -n "${node}" ]] || { echo "[ERROR] undefined node : ${node} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  [[ -n "${task}" ]] || { echo "[ERROR] undefined task : ${task} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  declare -f task_${task} >/dev/null || { echo "[ERROR] undefined task : ${task} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  task_${task} ${node} ${args}
}

function makistrano_xnode() {
  local task=$1; shift
  local args="$*"
  [[ -n "${task}" ]] || { echo "[ERROR] Invalid argument: task:${task} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  declare -f nodes >/dev/null || return 0

  for node in $(nodes); do
    makistrano_node ${node} ${task} ${args}
  done
}

function makistrano_load_config() {
  local file_path=$1
  [[ -a "${file_path}" ]] || { echo "[ERROR] Invalid argument: file_path:${file_path} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  . ${file_path}
}

function makistrano_cli() {
  local role=$1 task=$2; shift; shift
  local args="$*"
  local namespace=${task%%:*} name=${task##*:}
  [[ -n "${role}"   ]] || { echo "[ERROR] 'role' undefined (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  [[ -n "${task}"   ]] || { echo "[ERROR] 'task' undefined (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  makistrano_load_config ${config:-./Makistranofile}
  role_${role} >/dev/null || { echo "[ERROR] undefined role : ${role} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  [[ "${name}" == "${namespace}" ]] || {
    # named task
    namespace_${namespace} >/dev/null || { echo "[ERROR] undefined namespace : ${namespace} (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  }

  makistrano_xnode ${name} ${args}
}

# CLI
if [[ "${BASH_SOURCE[0]##*/}" == "makistrano" ]]; then
  makistrano_cli $*
fi
