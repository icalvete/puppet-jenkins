class jenkins::params {

  $repo_scheme            = 'http'
  $repo_domain            = 'pkg.jenkins-ci.org'
  $repo_port              = false
  $repo_user              = false
  $repo_pass              = false
  $repo_path              = 'debian/binary'
  $repo_resource          = 'jenkins_1.596_all.deb'

  $port                   = hiera('jenkins_port')
  $sport                  = hiera('jenkins_sport')
  $skey                   = hiera('jenkins_skey')
  $admin_user             = hiera('jenkins_admin_user')
  $admin_pass             = hiera('jenkins_admin_pass')
  $plugins                = hiera('jenkins_plugins')
  $prepare_cluster_backup = '/root/jenkins.tar'
  $service                = 'jenkins'
  $config_path            = '/var/lib/jenkins'
  $user                   = 'jenkins'
  $plugin_parent_dir      = '/var/lib/jenkins'
  $plugin_dir             = '/var/lib/jenkins/plugins'
  $keystore               = 'puppet:///modules/sp/jenkins_keys/keystore'

  $ldap_host              = hiera('ldap_host')
  $ldap_suffix            = hiera('ldap_suffix')
  $ldap_admin_user        = hiera('ldap_admin_user')
  $ldap_admin_pass        = hiera('ldap_admin_pass')

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
