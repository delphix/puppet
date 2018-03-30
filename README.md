# Delphix Target Host

#### Table of Contents

  1. [Description](#description)
  2. [Setup - The basics of getting started with delphix](#setup)
      * [Beginning with Delphix](#beginning-with-delphix)
  3. [Usage - Configuration options and additional functionality](#usage)
  5. [Limitations - OS compatibility, etc.](#limitations)
  6. [License](#license)

## Description
This module will configure a Linux system for use as a target host in the Delphix platform. This includes installing all required packages, and creating a `delphix` user with sufficient sudo privileges support all platform operations, most notably managing NFS mounts.  The resulting host can be used with a standard username, directories, and SSH key access.

## Setup
The module provides a mechanism for configuring the `delphix` user with a single engine public SSH key in `/home/delphix/.ssh/authorized_keys`. In the event that you are building a cloud image and want to configure the SSH key at runtime, you can use cloud init (as described for AWS [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)) to append one or more SSH keys to the `authorized_keys` file on first boot. To get the public SSH key of an engine, use the `system get sshPublicKey` CLI command.

### Beginning with Delphix
The Delphix module can configure the target host automatically with default settings. If you want to set up a target host quickly, apply the following manifest:

```
class { 'delphix': }
```

## Usage
In the event that your target host needs to have a different user:group than `delphix` or different mount and toolkit directories, custom parameters can be passed when instantiating the delphix class.

```
class { 'delphix':
  target_user => 'delphix',
  target_group => 'delphix',
  target_mount => '/mnt/delphix',
  target_toolkit => '/home/delphix/toolkit',
  target_ssh_user => 'delphix',
  target_ssh_key => 'AAAAB3Nza[...]qXfdaQ=='
}
```

The delphix module configures a target host by default, but if you only want to configure a target host it can be called directly:

```
class { 'delphix::targethost':
  target_user => 'delphix',
  target_group => 'delphix',
  target_mount => '/mnt/delphix',
  target_toolkit => '/home/delphix/toolkit',
  target_ssh_user => 'delphix',
  target_ssh_key => 'AAAAB3Nza[...]qXfdaQ=='
}
```

## Limitations

This module has been manually tested against latest Ubuntu and CentOS AMIs, but there is no reason it should not work with any RedHat or Debian variant.

## License

Apache 2.0
