# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

class bigtop::zookeeper::server(
  $myid           = $bigtop::zookeeper::params::myid,
  $ensemble       = $bigtop::zookeeper::params::ensemble,
  $kerberos_realm = $bigtop::zookeeper::params::kerberos_realm,
) inherits bigtop::zookeeper {

  package { "zookeeper-server":
    ensure => latest,
  }

  file { "/var/lib/zookeeper/myid":
    content => inline_template("<%= myid %>"),
    require => Package["zookeeper-server"],
  }

  service { "zookeeper-server":
    ensure => running,
    require => [ Package["zookeeper-server"], 
                 Exec["zookeeper-server-initialize"] ],
    subscribe => [ File["/etc/zookeeper/conf/zoo.cfg"],
                   File["/var/lib/zookeeper/myid"] ],
    hasrestart => true,
    hasstatus => true,
  } 

  exec { "zookeeper-server-initialize":
    command => "/usr/bin/zookeeper-server-initialize",
    user    => "zookeeper",
    creates => "/var/lib/zookeeper/version-2",
    require => Package["zookeeper-server"],
  }
}
