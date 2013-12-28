class jenkins::config {

  $plugin_dir        = $jenkins::params::plugin_dir
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
  }

  if $jenkins::sonar {
    include sonar::params

    file {"${config_path}/sonar":
        ensure  => directory,
        owner   => $jenkins::params::user,
        group   => $jenkins::params::group,
    }

    file{'sonar_runner_configuration':
      ensure  => present,
      content => template("${module_name}/hudson.plugins.sonar.SonarRunnerInstallation.xml.erb"),
      path    => "${jenkins::params::config_path}/hudson.plugins.sonar.SonarRunnerInstallation.xml",
      owner   => $jenkins::params::user,
      group   => $jenkins::params::group,
      mode    => '0644',
    }

    file{'sonar_configuration':
      ensure  => present,
      content => template("${module_name}/hudson.plugins.sonar.SonarPublisher.xml.erb"),
      path    => "${jenkins::params::config_path}/hudson.plugins.sonar.SonarPublisher.xml",
      owner   => $jenkins::params::user,
      group   => $jenkins::params::group,
      mode    => '0644',
    }
  }

  if $cluster {
    exec{'create-jenkins-cluster-initd':
      command => "/bin/mv /etc/init.d/${jenkins::params::service} /etc/init.d/${jenkins::params::service}-cluster",
      unless  => "/usr/bin/test -f /etc/init.d/${jenkins::params::service}-cluster",
    }

    file {"/etc/init.d/${jenkins::params::service}":
      ensure  => present,
      content => template("${module_name}/jenkins.init.erb"),
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      require => Exec['create-jenkins-cluster-initd'],
    }
  }
}
