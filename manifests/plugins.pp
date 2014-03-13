class jenkins::plugins {

  @jenkins::plugin { 'scm-api': }
  @jenkins::plugin { 'git-client': }
  @jenkins::plugin { 'git': }
  @jenkins::plugin { 'warnings': }
  @jenkins::plugin { 'htmlpublisher': }
  @jenkins::plugin { 'analysis-core': }
  @jenkins::plugin { 'sonar': }
  @jenkins::plugin { 'greenballs': }

  if $jenkins::plugins != []{
    realize(Jenkins::Plugin[$jenkins::plugins])
  }
}
