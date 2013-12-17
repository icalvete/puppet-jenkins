class jenkins::params {

  $admin_user             = hiera('jenkins_admin_user')
  $admin_pass             = hiera('jenkins_admin_pass')
  $plugins                = hiera('jenkins_plugins')
  $prepare_cluster_backup = '/root/jenkins.tar'
  $service                = 'jenkins'
  $config_path            = '/var/lib/jenkins'
  $user                   = 'jenkins'
  $plugin_parent_dir      = '/var/lib/jenkins'
  $plugin_dir             = '/var/lib/jenkins/plugins'

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $installer            = '/usr/bin/dpkg'
      $group                = 'nogroup'
      $pre_package          = ['openjdk-7-jre', 'daemon']
      $config_file_defaults = '/etc/default/jenkins'
    }
    /^(CentOS|RedHat)$/: {
      $installer            = '/bin/rpm'
      $group                = 'jenkins'
      $pre_package          = 'java-1.6.0-openjdk'
      $config_file_defaults = '/etc/sysconfig/jenkins'
    }
    default: {
      fail ("${::operatingsystem} not supported.")
    }
  }
}
