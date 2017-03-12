class jenkins::plugins {

  if is_array($jenkins::plugins) {
    $plugins = split(inline_template("<%= (scope.lookupvar('jenkins::plugins')+scope.lookupvar('jenkins::params::plugins')).join(',') %>"),',')
  } else {
    $plugins = $jenkins::params::plugins
  }

  jenkins::plugin{$plugins:}
}
