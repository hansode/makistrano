Makistrano
==========

Makistrano is a kind of bash implementation of [Capistrano](https://github.com/capistrano/capistrano).

Makistrano is a utility and framework for executing commands on multiple remote machines, via SSH.
It uses a simple DSL that allows you to define tasks, which may be applied to machines in certain roles.

Getting Started
---------------

### Creating `Makifile`

```
role_development() {
  nodes() {
    echo 192.0.2.1{0..9}
  }
}

role_production() {
  nodes() {
    curl http://example.com/hosts/production
  }
}

task_hostname() {
  local host=$1; shift

  # local
  hostname
  # remote
  ssh ${host} hostname
}

namespace_iptables() {
  task_start() {
    local host=$1; shift
    ssh ${host} /etc/init.d/iptables start
  }

  task_stop() {
    local host=$1; shift
    ssh ${host} /etc/init.d/iptables stop
  }

  task_restart() {
    local host=$1; shift
    ssh ${host} /etc/init.d/iptables restart
  }

  task_status() {
    local host=$1; shift
    ssh ${host} /etc/init.d/iptables status
  }
}
```

### Running `makistrano`

```
$ makistrano development hostname

$ makistrano development iptables:status
$ makistrano development iptables:stop
$ makistrano development iptables:start
$ makistrano development iptables:restart
```

```
$ makistrano production hostname

$ makistrano production iptables:status
$ makistrano production iptables:stop
$ makistrano production iptables:start
$ makistrano production iptables:restart
```

Usage
-----

```
$ makistrano [role] [task]
$ makistrano [role] [namespace:task]
```

Installation
------------

```
$ mkdir /opt/hansode
$ cd    /opt/hansode

$ git clone https://github.com/hansode/makistrano.git
```

Makifile
--------

The Makifile is a Bash file used to configure Makistrano on a per-project basis.
