# Class: corp104_rvm
# ===========================
#
# Full description of class corp104_rvm here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'corp104_rvm':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class corp104_rvm (
  Optional[String] $http_proxy,
  Array $dependencie_package,
  String $ppa,
  String $package_name,
  String $gpg_key,
  String $rvm_script_url,
  String $rvm_install_tmp,
  String $rvm_profile,
  String $ruby_version,
  Boolean $set_default,
){
  contain corp104_rvm::install
  contain corp104_rvm::install::ruby

  Class['::corp104_rvm::install']
  -> Class['::corp104_rvm::install::ruby']
}
