class bigtop(
  $repo_file = $bigtop::params::repo_file,
) inherits bigtop::params {
  
  class { "bigtop::repo":
    repo_url => $repo_url,
  }

  Class['bigtop::repo'] -> Package<||>
}
