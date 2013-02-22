class bigtop::params {
   $repo_url = $::operatingsystem ? {
     'CentOS'   => "http://bigtop01.cloudera.org:8080/view/Bigtop-trunk/job/Bigtop-trunk-Repository/label=centos${lsbmajdistrelease}/lastSuccessfulBuild/artifact/repo",
     'Fedora'   => "http://bigtop01.cloudera.org:8080/view/Bigtop-trunk/job/Bigtop-trunk-Repository/label=fedora${lsbmajdistrelease}/lastSuccessfulBuild/artifact/repo",
     'Ubuntu'   => "http://bigtop01.cloudera.org:8080/view/Bigtop-trunk/job/Bigtop-trunk-Repository/label=${lsbdistcodename}/lastSuccessfulBuild/artifact/repo",
     'OpenSuSE' => "http://bigtop01.cloudera.org:8080/view/Bigtop-trunk/job/Bigtop-trunk-Repository/label=opensuse12/lastSuccessfulBuild/artifact/repo",  
     'SLES'     => "http://bigtop01.cloudera.org:8080/view/Bigtop-trunk/job/Bigtop-trunk-Repository/label=sles11/lastSuccessfulBuild/artifact/repo",
     default    => "http://unsupported",
   }

   $repo_file = $::operatingsystem ? {
     'Ubuntu'   => "$repo_url/bigtop.list",
     default    => "$repo_url/bigtop.repo",
   }

   $kerberos_realm = ''
}
