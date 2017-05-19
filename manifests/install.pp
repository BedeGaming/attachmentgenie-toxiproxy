# Class to install toxiproxy.
#
# Dont include this class directly.
#
class toxiproxy::install {
  case $::toxiproxy::install_method {
    'package': {
      package { $::toxiproxy::package_name:
        ensure => $::toxiproxy::package_version,
      }
    }
    'wget': {
      file { $::toxiproxy::install_dir:
        ensure => directory,
      }
      -> wget::fetch { '/usr/bin/toxiproxy':
        source      => $::toxiproxy::wget_source,
        destination => "${::toxiproxy::install_dir}/toxiproxy",
        timeout     => 0,
        verbose     => false,
      }
      -> file { "${::toxiproxy::install_dir}/toxiproxy":
        group => 'root',
        mode  => '0755',
        owner => 'root',
      }
    }
    default: {
      fail("Installation method ${::toxiproxy::install_method} not supported")
    }
  }
}