# delphix::targethost
#
# Configures a linux system to be a target host.
#
# Copyright (c) 2018 by Delphix. All rights reserved.
#
# @summary
# Creates a new user and group
# Creates proper directories and sets ownership and permissions
# Enables sudo access for new user
#
# @example
#   include delphix::targethost
class delphix::targethost (
    $delphix_user     = $::delphix::target_user,
    $delphix_group    = $::delphix::target_group,
    $delphix_mount    = $::delphix::target_mount,
    $delphix_toolkit  = $::delphix::target_toolkit,
    $delphix_ssh_user = $::delphix::target_ssh_user,
    $delphix_ssh_key  = $::delphix::target_ssh_key,
  ){

  case $::osfamily {
    'redhat': {
      package { 'nfs-utils': ensure => 'installed' }
    }
    'debian': {
      exec { 'enable-32-bit-architecture':
        command => 'dpkg --add-architecture i386',
        path    => ['/usr/bin', '/usr/sbin', '/bin'],
        onlyif  => 'dpkg --print-foreign-architectures | grep -c i386'
      }
      $packages = ['libc6:i386','libstdc++6:i386','nfs-common','sudo']
      package { $packages: ensure => 'installed' }
    }
    default: {
      # ...
    }
  }

  group { 'add-delphix-group':
    ensure => present,
    name   => $delphix_group
  }

  file { "/home/${delphix_user}":
    ensure => 'directory',
    owner  => $delphix_user,
    group  => $delphix_group,
    mode   => '0700'
  }

  user { 'add-delphix-user':
    name       => $delphix_user,
    managehome => true,
    home       => "/home/${delphix_user}",
    groups     => $delphix_group,
    comment    => 'Delphix Automation'
  }

  file { $delphix_toolkit:
    ensure => 'directory',
    owner  => $delphix_user,
    group  => $delphix_group,
    mode   => '0700'
  }

  file { "/home/${delphix_user}/.ssh":
    ensure => 'directory',
    owner  => $delphix_user,
    group  => $delphix_group,
    mode   => '0700'
  }

  file { $delphix_mount:
    ensure => 'directory',
    owner  => $delphix_user,
    group  => $delphix_group,
    mode   => '0700'
  }

  file { "/home/${delphix_user}/.ssh/authorized_keys":
    ensure => 'file',
    owner  => $delphix_user,
    group  => $delphix_group,
    mode   => '0600'
  }

  if ($delphix_ssh_user != '') and ($delphix_ssh_key != '') {
    ssh_authorized_key { 'ssh-user-key':
      ensure => present,
      user   => $delphix_ssh_user,
      type   => 'ssh-rsa',
      key    => $delphix_ssh_key
    }
  }

  exec { 'configure-delphix-user-for-sudo-tty':
    command => "sudo echo 'Defaults:${delphix_user} !requiretty' >> /etc/sudoers",
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    onlyif  => "sudo grep -c 'Defaults:${delphix_user} !requiretty' /etc/sudoers"
  }

  exec { 'configure-delphix-user-for-sudoers':
    command => "sudo echo '${delphix_user} ALL=NOPASSWD: /bin/mount, /bin/umount, /bin/ps, /bin/mkdir, /bin/rmdir' >> /etc/sudoers",
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    onlyif  => "sudo grep -c '${delphix_user} ALL=NOPASSWD: /bin/mount, /bin/umount, /bin/ps, /bin/mkdir, /bin/rmdir' /etc/sudoers"
  }

  exec { 'validate-etc-sudoers':
    command     => 'sudo visudo -cf /etc/sudoers',
    path        => ['/usr/bin', '/usr/sbin', '/bin'],
    refreshonly => true
  }
}
