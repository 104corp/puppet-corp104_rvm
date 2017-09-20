class corp104_rvm::install::ruby inherits corp104_rvm {
  Exec { path => '/sbin:/bin:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/rvm/bin' }

  if $corp104_rvm::http_proxy {
    exec { 'install-ruby':
      environment => [
        "http_proxy=${corp104_rvm::http_proxy}",
        "https_proxy=${corp104_rvm::http_proxy}",
      ],
      command     => "/bin/bash rvm install ${corp104_rvm::ruby_version} \
                     && rvm alias create default ${corp104_rvm::ruby_version}",
      unless      => "/bin/bash -c '. ${corp104_rvm::rvm_profile} && which ruby'",
      require     => Class['corp104_rvm::install'],
    }
  }
  else {
    exec { 'install-ruby':
      command => "/bin/bash rvm install ${corp104_rvm::ruby_version} \
                 && rvm alias create default ${corp104_rvm::ruby_version}",
      unless  => "/bin/bash -c '. ${corp104_rvm::rvm_profile} && which ruby'",
      require => Class['corp104_rvm::install'],
    }
  }

  if $corp104_rvm::set_default {
    exec { 'set-default-ruby':
      command => "/bin/bash rvm alias create default ${corp104_rvm::ruby_version}",
      unless  => "/bin/bash -c '. ${corp104_rvm::rvm_profile} && ruby -v | grep ${corp104_rvm::ruby_version}'",
      require => Exec['install-ruby'],
    }
  }
}
