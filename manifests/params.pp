class jenkins::params {

  $repo_scheme            = 'http'
  $repo_domain            = 'pkg.jenkins-ci.org'
  $repo_port              = false
  $repo_user              = false
  $repo_pass              = false
  $repo_path              = 'debian/binary'
  $repo_resource          = 'jenkins_1.658_all.deb'

  $jenkins_plugins = [
   'scm-api',
   'git-client',
   'git',
   'htmlpublisher',
   'analysis-core',
   'greenballs',
   'postbuild-task',
   'xunit',
   'junit',
   'warnings',
   'join',
   'sonar',
   'jquery',
   'ansicolor',
   'parameterized-trigger',
   'token-macro',
   'run-condition',
   'conditional-buildstep',
   'flexible-publish',
   'any-buildstep'
  ]

  $port                   = hiera('jenkins_port', '8008')
  $sport                  = hiera('jenkins_sport', '8084')
  $admin_user             = hiera('jenkins_admin_user', 'jenkins')
  $admin_pass             = hiera('jenkins_admin_pass', 'changeme')
  $plugins                = hiera('jenkins_plugins', $jenkins_plugins)
  $service                = 'jenkins'
  $config_path            = '/var/lib/jenkins'
  $user                   = 'jenkins'
  $plugin_parent_dir      = '/var/lib/jenkins'
  $plugin_dir             = '/var/lib/jenkins/plugins'
  $skey                   = hiera('jenkins_skey', 'j3nk1nsk3y')
  $keystore               = "puppet:///modules/${module_name}/keystore"

  if $jenkins::ldap {
    $ldap_host              = hiera('ldap_host', 'localhost')
    $ldap_suffix            = hiera('ldap_suffix', 'dc=example,dc=net')
    $ldap_admin_user        = hiera('ldap_admin_user', 'cn=Directory Manager')
    $ldap_admin_pass        = hiera('ldap_admin_pass', 'changeme')
  }

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      $installer            = '/usr/bin/dpkg'
      $group                = 'jenkins'
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
