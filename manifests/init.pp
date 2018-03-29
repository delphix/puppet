# delphix
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include delphix
class delphix (
  String  $delphix_user = $::delphix::params::delphix_user,
  String  $delphix_group = $::delphix::params::delphix_group,
  String  $delphix_mount = $::delphix::params::delphix_mount,
  String  $delphix_toolkit = $::delphix::params::delphix_toolkit,
  String  $delphix_ssh_user = $::delphix::params::delphix_ssh_user,
  String  $delphix_ssh_key = $::delphix::params::delphix_ssh_key
) inherits ::delphix::params {

  contain '::delphix::config'

}
