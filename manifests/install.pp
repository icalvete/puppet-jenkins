class jenkins::install {

  common::down_resource {'jenkins_get_package':
    scheme   => $jenkins::repo_scheme,
    domain   => $jenkins::repo_domain,
    port     => $jenkins::repo_port,
    user     => $jenkins::repo_user,
    pass     => $jenkins::repo_pass,
    path     => $jenkins::repo_path,
    resource => $jenkins::repo_resource,
  }

  realize Package[$jenkins::params::pre_package]

  exec {'jenkins_install_package':
    cwd     => '/tmp/',
    command => "${jenkins::params::installer} -i ${jenkins::repo_resource}",
    require => [Package[$jenkins::params::pre_package], Common::Down_resource['jenkins_get_package']],
    unless  => "/usr/bin/test -d ${jenkins::params::config_path}"
  }
}

