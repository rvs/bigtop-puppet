class bigtop(
  $repo_file = $bigtop::params::repo_file,
  $kerberos_realm = $bigtop::params::kerberos_realm
) inherits bigtop::params {
  
  class { "bigtop::repo":
    repo_url => $repo_url,
  }

  Class['bigtop::repo'] -> Package<||>
}
