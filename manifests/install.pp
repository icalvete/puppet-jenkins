class jenkins::install {

  $source = "${jenkins::repo_scheme}://${jenkins::repo_domain}/${jenkins::repo_path}/${jenkins::repo_resource}"

  wget::fetch {'jenkins_get_package':
    source      => $source,
    user        => $jenkins::repo_user,
    password    => $jenkins::repo_pass,
    destination => "/tmp/${jenkins::repo_resource}",
    timeout     => 0,
    verbose     => false,
  }

  realize Package[$jenkins::params::pre_package]

  exec {'jenkins_install_package':
    cwd     => '/tmp/',
    command => "${jenkins::params::installer} -i ${jenkins::repo_resource}",
    require => [Package[$jenkins::params::pre_package], Wget::Fetch['jenkins_get_package']],
    unless  => "/usr/bin/test -d ${jenkins::params::config_path}"
  }
}

