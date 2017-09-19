class corp104_rvm::install::ubuntu inherits corp104_rvm {
  Exec { path => '/sbin:/bin:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/rvm/bin' }

  exec { 'import-gpg-key':
    command => "/usr/bin/gpg --recv-keys ${corp104_rvm::gpg_key}",
    unless  => '/usr/bin/gpg --list-keys | grep RVM',
  }

  if $corp104_rvm::http_proxy {
    exec { 'download-install-sh':
      provider => 'shell',
      command  => "curl -sSL -x ${corp104_rvm::http_proxy} \
                  && -o ${corp104_rvm::rvm_install_tmp} \
                  && -O ${corp104_rvm::rvm_script_url}",
      unless   => 'which rvm',
    }
    exec { 'install-rvm':
      provider => 'shell',
      command  => "export ${corp104_rvm::http_proxy} ＼
                   && bash -s stable ${corp104_rvm::rvm_install_tmp}",
      unless   => 'which rvm',
    }
  }
  else {
    exec { 'install-rvm':
      provider => 'shell',
      command  => "curl -sSL ${corp104_rvm::rvm_script_url} | bash -s stable",
      unless   => 'which rvm',
      notify   => Class['corp104_rvm::install::ruby'],
    }
  }

}