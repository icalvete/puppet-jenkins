# puppet-jenkins

Puppet manifest to install and configure Jenkins

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-jenkins.png)](http://travis-ci.org/icalvete/puppet-jenkins)

See [Jenkins site](http://jenkins-ci.org/)

## Requires:

* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/maestrodev/puppet-wget
* For LDAP auth, administrator user is jenkins and only scm group members can do any stuff
* **For sonar support https://github.com/icalvete/sonar and sonar server with mysql as backend**

## Usage

```puppet
  class {'roles::jenkins_server':
    admin_pass => 'WHATEVER',
    ssl        => true,
    keystore   => 'puppet:///modules/cg_common/ssl/jenkins_keystore.jks'
  }
```

### Generate a JKS

In this example the cert it's a wildcard. In other case use the FQDN.

```
icalvete@dagon ~/puppet-jenkins$ cd files/tools
icalvete@dagon ~/puppet-jenkins/files/tools$./create_PKCS12.sh cg.key  cg.crt ca_intermediate.crt *.cremagames.com
icalvete@dagon ~/puppet-jenkins/files/tools$./create_JKS.sh *.cremagames.com
```


## Authors:

Israel Calvete Talavera <icalvete@gmail.com>
