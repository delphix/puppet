# Delphix
#
# Configure a Linux system for use as a target host in the Delphix platform.
#
# Copyright (c) 2018 by Delphix. All rights reserved.
#
# @summary
# Configures a target host by default.
#
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
