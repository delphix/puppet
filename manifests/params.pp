# delphix::params
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include delphix::params
class delphix::params {
  $target_user = 'delphix'
  $target_group  =  'delphix'
  $target_mount  =  "/mnt/${target_user}"
  $target_toolkit  =  "/home/${target_user}/toolkit"
  $target_ssh_user = ''
  $target_ssh_key  = ''
}
