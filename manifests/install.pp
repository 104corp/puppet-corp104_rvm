class corp104_rvm::install inherits corp104_rvm {
  if $facts['os']['name'] == 'Ubuntu' {
    class { 'corp104_rvm::install::ubuntu': }
  }
  else {
    fail ("Unsupport version.")
  }

  exec { 'install-ruby':
    path    => '/bin:/usr/sbin:/usr/bin:/sbin',
    command => "/bin/bash -c export http_proxy=${corp104_rvm::http_proxy} add-apt-repository -y ppa:${corp104_rvm::ppa} && apt-get update",
    user    => 'root',
    unless  => "apt-cache policy | grep ${corp104_rvm::ppa}",
  }
}