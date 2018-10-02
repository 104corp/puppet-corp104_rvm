class corp104_rvm::install::redhat inherits corp104_rvm {

  Exec { path => '/sbin:/bin:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/rvm/bin' }

  exec { 'import-gpg2-key':
    environment => [
      "http_proxy=${corp104_rvm::http_proxy}",
      "https_proxy=${corp104_rvm::http_proxy}",
    ],
    command => 'curl -sSL https://rvm.io/mpapis.asc | sudo gpg2 --import -',
    unless  => '/usr/bin/gpg2 --list-keys | grep RVM',
  }

  if $corp104_rvm::http_proxy {
    exec { 'download-install-sh':
      provider => 'shell',
      command  => "curl -sSL -x ${corp104_rvm::http_proxy} -o ${corp104_rvm::rvm_install_tmp} -O ${corp104_rvm::rvm_script_url}",
      unless   => 'which rvm',
    }
    exec { 'install-rvm':
      provider    => 'shell',
      environment => [
        "http_proxy=${corp104_rvm::http_proxy}",
        "https_proxy=${corp104_rvm::http_proxy}",
      ],
      command     => "bash -s stable ${corp104_rvm::rvm_install_tmp}",
      unless      => 'which rvm',
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
