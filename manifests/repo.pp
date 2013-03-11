class bigtop::repo(
  $repo_url
) {

  case $::operatingsystem {
    /(OracleLinux|CentOS|Fedora|RedHat)/: {
      file { "/etc/yum.repos.d/bigtop.repo":
        content => template("bigtop/bigtop.repo.erb"),
      }
    }

    /Ubuntu/: {
      file { "/etc/apt/sources.list.d/bigtop.list":
        content => "deb $repo_url bigtop contrib",
      }

      exec { "/usr/bin/apt-get update":
        require => File["/etc/apt/sources.list.d/bigtop.list"],
      }
    }

    /(OpenSuSE|SLES)/: {
      exec { "/usr/bin/zypper addrepo $repo_url":
      }
    }

    default: {
      notify{"WARNING: running on an unrecognized platform $::operatingsystem -- make sure Bigtop repo is setup": }
    }
  } 
}
