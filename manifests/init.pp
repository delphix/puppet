# delphix
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#r
# @example
#   include delphix
class delphix (
  String  $target_user = $::delphix::params::target_user,
  String  $target_group = $::delphix::params::target_group,
  String  $target_mount = $::delphix::params::target_mount,
  String  $target_toolkit = $::delphix::params::target_toolkit,
  String  $target_ssh_user = $::delphix::params::target_ssh_user,
  String  $target_ssh_key = $::delphix::params::target_ssh_key
) inherits ::delphix::params {

  contain '::delphix::targethost'

}
