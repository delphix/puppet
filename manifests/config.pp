# delphix::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include delphix::config
class delphix::config {
  $delphix_user     = $::delphix::delphix_user
  $delphix_group    = $::delphix::delphix_group
  $delphix_mount    = $::delphix::delphix_mount
  $delphix_toolkit  = $::delphix::delphix_toolkit
  $delphix_ssh_user = $::delphix::delphix_ssh_user
  $delphix_ssh_key  = $::delphix::delphix_ssh_key

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
    home       => '/home/delphix',
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
    command => "sudo echo 'Defaults:delphix_user !requiretty' >> /etc/sudoers",
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    onlyif  => "sudo grep -c 'Defaults:delphix_user !requiretty' /etc/sudoers"
  }

  exec { 'configure-delphix-user-for-sudoers':
    command => "sudo echo 'delphix_user ALL=NOPASSWD: /bin/mount, /bin/umount, /bin/ps, /bin/mkdir, /bin/rmdir' >> /etc/sudoers",
    path    => ['/usr/bin', '/usr/sbin', '/bin'],
    onlyif  => "sudo grep -c 'delphix_user ALL=NOPASSWD: /bin/mount, /bin/umount, /bin/ps, /bin/mkdir, /bin/rmdir' /etc/sudoers"
  }

  exec { 'validate-etc-sudoers':
    command     => 'sudo visudo -cf /etc/sudoers',
    path        => ['/usr/bin', '/usr/sbin', '/bin'],
    refreshonly => true
  }
}
