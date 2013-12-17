class jenkins::prepare_cluster (

  $jenkins_datadir = $jenkins::params::config_path,
  $backup          = $jenkins::params::prepare_cluster_backup,
  $service         = $jenkins::params::service

) {

  file{'/etc/.jenkins.lock':
    ensure => present,
    notify => Exec['jenkins-backup']
  }

  exec{'jenkins-backup':
    command     => "/bin/tar c ./* > $backup",
    cwd         => $jenkins_datadir,
    logoutput   => true,
    creates     => $backup,
    refreshonly => true,
  }

  exec{'stop-jenkins-service':
    command => "/sbin/service $service stop",
  }

}

