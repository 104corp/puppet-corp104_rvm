class corp104_rvm::install inherits corp104_rvm {

  if $facts['os']['family'] == 'Debian' {
    class { 'corp104_rvm::install::ubuntu': }
  }
  elsif $facts['os']['family'] == 'RedHat' {
    class { 'corp104_rvm::install::redhat': }
  }
  else {
    fail ("Unsupport ${facts['os']['family']}.")
  }
}