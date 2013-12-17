class jenkins::plugins {

  @jenkins::plugin { 'git-client': }
  @jenkins::plugin { 'git': }
  @jenkins::plugin { 'warnings': }
  @jenkins::plugin { 'htmlpublisher': }
  @jenkins::plugin { 'analysis-core': }

  if $jenkins::plugins != []{
    realize(Jenkins::Plugin[$jenkins::plugins])
  }
}
