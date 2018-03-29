# delphix::params
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include delphix::params
class delphix::params {
  $delphix_user = 'delphix'
  $delphix_group  =  'delphix'
  $delphix_mount  =  "/mnt/${delphix_user}"
  $delphix_toolkit  =  "/home/${delphix_user}/toolkit"
  $delphix_ssh_user = ''
  $delphix_ssh_key  = ''
}
