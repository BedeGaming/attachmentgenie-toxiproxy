# Class to install toxiproxy.
#
# Dont include this class directly.
#
class toxiproxy::install {
  case $::toxiproxy::install_method {
    'package': {
      package { 'toxiproxy':
        ensure => $::toxiproxy::package_version,
        name   => $::toxiproxy::package_name,
      }
    }
    'wget': {
      file { 'toxiproxy install dir':
        ensure => directory,
        path   => $::toxiproxy::install_dir,
      }
      -> wget::fetch { 'toxiproxy binary':
        source      => $::toxiproxy::wget_source,
        destination => "${::toxiproxy::install_dir}/toxiproxy",
        timeout     => 0,
        verbose     => false,
      }
      -> file { 'toxiproxy binary':
        group => 'root',
        mode  => '0755',
        owner => 'root',
        path  => "${::toxiproxy::install_dir}/toxiproxy",
      }
    }
    default: {
      fail("Installation method ${::toxiproxy::install_method} not supported")
    }
  }
}
