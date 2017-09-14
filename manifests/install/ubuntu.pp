class corp104_rvm::install::ubuntu inherits corp104_rvm {
  Exec { path => '/bin:/usr/bin:/usr/local/bin:/usr/sbin:/usr/local/rvm/bin' }

  exec { 'install-ppa':
    command => "/bin/bash -c export http_proxy=${corp104_rvm::http_proxy} add-apt-repository -y ppa:${corp104_rvm::ppa} && apt-get update",
    user    => 'root',
    unless  => "apt-cache policy | grep ${corp104_rvm::ppa}",
  }

  package { $corp104_rvm::dependencie_package:
    ensure  => present,
    require => Exec['install-ppa'],
  }

  package { $corp104_rvm::package_name:
    ensure  => present,
    require => Package[$corp104_rvm::dependencie_package],
  }
}