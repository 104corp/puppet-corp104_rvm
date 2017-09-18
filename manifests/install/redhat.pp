class corp104_rvm::install::redhat inherits corp104_rvm {

  Exec { path => '/bin:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/rvm/bin' }

  exec { 'import-gpg2-key':
    command => "/usr/bin/gpg2 --recv-keys ${corp104_rvm::gpg_key}",
    unless  => '/usr/bin/gpg2 --list-keys | grep RVM',
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