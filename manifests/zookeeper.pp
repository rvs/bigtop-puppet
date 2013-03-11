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

class bigtop::zookeeper(
  $ensemble       = $bigtop::zookeeper::params::ensemble,
  $kerberos_realm = $bigtop::zookeeper::params::kerberos_realm,
) inherits bigtop::zookeeper::params {

  package { "zookeeper":
    ensure => latest,
  } 

  file { "/etc/zookeeper/conf/zoo.cfg":
    content => template("bigtop/zookeeper/zoo.cfg.erb"),
    require => Package["zookeeper"],
  }

  if ($kerberos_realm != '') {
    #kerberos::host_keytab { "zookeeper":
    #  spnego => true,
    #}

    file { "/etc/zookeeper/conf/java.env":
      source  => "puppet:///modules/bigtop/zookeeper/java.env",
      require => Package["zookeeper-server"],
      notify  => Service["zookeeper-server"],
    }

    file { "/etc/zookeeper/conf/jaas.conf":
      content => template("bigtop/zookeeper/jaas.conf.erb"),
      require => Package["zookeeper-server"],
      notify  => Service["zookeeper-server"],
    }
  }
}
