class jenkins (

  $repo_scheme     = $jenkins::params::repo_scheme,
  $repo_domain     = $jenkins::params::repo_domain,
  $repo_port       = $jenkins::params::repo_port,
  $repo_user       = $jenkins::params::repo_user,
  $repo_pass       = $jenkins::params::repo_pass,
  $repo_path       = $jenkins::params::repo_path,
  $repo_resource   = $jenkins::params::repo_resource,
  $admin_user      = $jenkins::params::admin_user,
  $admin_pass      = $jenkins::params::admin_user,
  $plugins         = undef,
  $ldap            = false,
  $ldap_host       = $jenkins::params::ldap_host,
  $ldap_suffix     = $jenkins::params::ldap_suffix,
  $ldap_admin_user = $jenkins::params::ldap_admin_user,
  $ldap_admin_pass = $jenkins::params::ldap_admin_pass,
  $ssl             = false,
  $skey            = $jenkins::params::skey,
  $keystore        = $jenkins::params::keystore,
  $sonar           = false

) inherits jenkins::params {

  if ! $repo_resource {
    fail('repo_resource parameter must be defined')
  }

  anchor{'jenkins::begin':
    before  => Class['jenkins::install']
  }
  class{'jenkins::install':
    require => Anchor['jenkins::begin']
  }
  class{'jenkins::config':
    require => Class['jenkins::install'],
    notify  => Class['jenkins::service']
  }
  class{'jenkins::plugins':
    require => Class['jenkins::config'],
    notify  => Class['jenkins::service']
  }
  class{'jenkins::service':
    require  => Class['jenkins::plugins']
  }

  anchor{'jenkins::end':
    require => Class['jenkins::service']
  }
}
