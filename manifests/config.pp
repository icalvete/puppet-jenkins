class jenkins::config {

  $plugin_dir        = $jenkins::plugin_dir
  $plugin_parent_dir = $jenkins::params::plugin_parent_dir

  if (!defined(File[$plugin_dir])) {
    file {[$plugin_parent_dir, $plugin_dir]:
        ensure  => directory,
        owner   => $jenkins::params::user,
        group   => $jenkins::params::group,
    }
  }

  file{'jenkins_defaults_configuration':
    ensure  => present,
    content => template("${module_name}/jenkins_defaults_${::osfamily}.erb"),
    path    => $jenkins::params::config_file_defaults,
    owner   => $jenkins::params::user,
    group   => $jenkins::params::group,
    mode    => '0644',
  }

  if $jenkins::ldap {
    $jenkins_configuration_file = "/jenkins_config_${::osfamily}_ldap.erb"
  } else {
    $jenkins_configuration_file = "/jenkins_config_${::osfamily}.erb"
  }

  file{'jenkins_configuration':
    ensure  => present,
    content => template("${module_name}/${jenkins_configuration_file}"),
    path    => "${jenkins::params::config_path}/config.xml",
    owner   => $jenkins::params::user,
    group   => $jenkins::params::group,
    mode    => '0644',
    backup  => true
  }

  file { 'ssh_directory_jenkins':
    ensure => directory,
    path   => "${jenkins::params::config_path}/.ssh",
    owner  => $jenkins::params::user,
    group  => $jenkins::params::group,
    mode   => '0700',
  }

  if $jenkins::ssl {
    file {'jenkins_keystore':
      ensure => present,
      source => $jenkins::keystore,
      path   => "${jenkins::params::config_path}/.keystore",
      owner  => $jenkins::params::user,
      group  => $jenkins::params::group,
      mode   => '0644',
    }
  }
}
