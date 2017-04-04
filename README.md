# puppet-jenkins

Puppet manifest to install and configure Jenkins

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-jenkins.png)](http://travis-ci.org/icalvete/puppet-jenkins)

See [Jenkins site](http://jenkins-ci.org/)

## Requires:

* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/maestrodev/puppet-wget
* For LDAP auth, administrator user is jenkins and only scm group members can do any stuff
* **For sonar support https://github.com/icalvete/sonar and sonar server with mysql as backend**


## Authors:

Israel Calvete Talavera <icalvete@gmail.com>
