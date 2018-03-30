# delphix::params
#
# Parameter definition for the Delphix module
#
# Copyright (c) 2018 by Delphix. All rights reserved.
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
