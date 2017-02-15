# attachmentgenie-toxiproxy

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
2. [Setup - The basics of getting started with toxiproxy](#setup)
    * [What toxiproxy affects](#what-toxiproxy-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with toxiproxy](#beginning-with-toxiproxy)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Module Description

toxiproxy is an email testing tool for developers:

    - Configure your application to use toxiproxy for SMTP delivery
    - View messages in the web UI, or retrieve them with the JSON API

## Setup

### What toxiproxy affects

- Configuration files and directories (created and written to)
- Package/service/configuration files for toxiproxy
- Listened-to ports

### Setup Requirements

none

### Beginning with toxiproxy

To have Puppet install toxiproxy with the default parameters, declare the toxiproxy class:

``` puppet
class { 'toxiproxy': }
```

You can customize parameters when declaring the `toxiproxy` class. For instance,
 this declaration installs toxiproxy by downloading a tarball instead of instead of using a package.

``` puppet
class { '::toxiproxy':
  install_method => 'wget',
  wget_source    => 'https://github.com/Shopify/toxiproxy/releases/download/v2.0.0/toxiproxy-server-linux-amd64',
}
```

## Limitations

This module currently only exposes a subset of all configuration options.

## Development

### Running tests

This project contains tests for both rspec-puppet and test kitchen to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart:

```
gem install bundler
bundle install
bundle exec rake guard
bundle exec kitchen test
