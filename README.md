# Delphix Target Host

[![Build Status](https://travis-ci.org/delphix/puppet.svg?branch=master)](https://travis-ci.org/delphix/puppet)
[![Puppet Forge](https://img.shields.io/puppetforge/v/delphix/delphix.svg)](https://forge.puppet.com/delphix/delphix)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/delphix/delphix.svg)](https://forge.puppet.com/delphix/delphix)

Configure a Linux system as a target host for the Delphix platform.

#### Table of Contents
1.  [Description](#description)
2.  [Installation](#installation)
3.  [Usage](#usage)
4.  [Links](#links)
5.  [Contribute](#contribute)
    *   [Code of conduct](#code-of-conduct)
    *   [Community Guidelines](#community-guidelines)
    *   [Contributor Agreement](#contributor-agreement)
6.  [Reporting Issues](#reporting-issues)
7.  [Statement of Support](#statement-of-support)
8.  [License](#license)

## <a id="description"></a>Description

This module will configure a Linux system for use as a target host in the Delphix platform. This includes installing all required packages, and creating a `delphix` user with sufficient sudo privileges support all platform operations, most notably managing NFS mounts.  The resulting host can be used with a standard username, directories, and SSH key access.

## <a id="installation"></a>Installation

To use this module, add this declaration to your Puppetfile:

`mod 'delphix-delphix', '0.1.1'`

To manually install this module with puppet module tool:

`puppet module install delphix-delphix --version 0.1.1`

More information can be found at the [Puppet Forge](https://forge.puppet.com/delphix/delphix).

## <a id="usage"></a>Usage

The module provides a mechanism for configuring the `delphix` user with a single engine public SSH key in `/home/delphix/.ssh/authorized_keys`. In the event that you are building a cloud image and want to configure the SSH key at runtime, you can use cloud init (as described for AWS [here](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html)) to append one or more SSH keys to the `authorized_keys` file on first boot. To get the public SSH key of an engine, use the `system get sshPublicKey` CLI command.

The Delphix module can configure the target host automatically with default settings. If you want to set up a target host quickly, apply the following manifest:

```
class { 'delphix': }
```

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

## <a id="links"></a>Links

*   [Beginner's guide to writing modules](https://puppet.com/docs/puppet/5.5/bgtm.html)
*   [The Puppet language style guide](https://puppet.com/docs/puppet/5.5/style_guide.html)
*   [Puppet Tips and Tricks](https://www.kumari.net/index.php/system-adminstration/85-puppet-tips-and-tricks)

## <a id="contribute"></a>Contribute

1.  Fork the project.
2.  Make your bug fix or new feature.
3.  Add tests for your code.
4.  Send a pull request.

Contributions must be signed as `User Name <user@email.com>`. Make sure to [set up Git with user name and email address](https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup). Bug fixes should branch from the current stable branch. New features should be based on the `master` branch. When creating a pull request, use `develop` as the base. 

#### <a id="code-of-conduct"></a>Code of Conduct

This project operates under the [Delphix Code of Conduct](https://delphix.github.io/code-of-conduct.html). By participating in this project you agree to abide by its terms.

#### <a id="contributor-agreement"></a>Contributor Agreement

All contributors are required to sign the Delphix Contributor agreement prior to contributing code to an open source repository. This process is handled automatically by [cla-assistant](https://cla-assistant.io/). Simply open a pull request and a bot will automatically check to see if you have signed the latest agreement. If not, you will be prompted to do so as part of the pull request process.

## <a id="reporting_issues"></a>Reporting Issues

Issues should be reported [here](https://github.com/delphix/puppet/issues).

## <a id="statement-of-support"></a>Statement of Support

This software is provided as-is, without warranty of any kind or commercial support through Delphix. See the associated license for additional details. Questions, issues, feature requests, and contributions should be directed to the community as outlined in the [Delphix Community Guidelines](https://delphix.github.io/community-guidelines.html).

## <a id="license"></a>License

This is code is licensed under the Apache License 2.0. Full license is available [here](./LICENSE).
