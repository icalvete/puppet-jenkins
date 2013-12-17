class jenkins::service {

  service { $jenkins::params::service:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}

