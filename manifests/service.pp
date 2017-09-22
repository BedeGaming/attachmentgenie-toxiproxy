# Class to manage the toxiproxy service.
#
# Dont include this class directly.
#
class toxiproxy::service {
  if $::toxiproxy::manage_service {
    case $::toxiproxy::service_provider {
      'debian','init','redhat': {
        file { 'toxiproxy service file':
          path    => "/etc/init.d/${::toxiproxy::service_name}",
          content => template("toxiproxy/toxiproxy.init.${::osfamily}.erb"),
          mode    => '0755',
          notify  => Service['toxiproxy'],
        }
      }
      'systemd': {
        ::systemd::unit_file { "${::toxiproxy::service_name}.service":
          content => template('toxiproxy/toxiproxy.service.erb'),
          before  => Service['toxiproxy'],
        }
      }
      default: {
        fail("Service provider ${::toxiproxy::service_provider} not supported")
      }
    }

    case $::toxiproxy::install_method {
      'package': {
        Service['toxiproxy'] {
          subscribe => Package['toxiproxy'],
        }
      }
      'wget': {}
      default: {
        fail("Installation method ${::toxiproxy::install_method} not supported")
      }
    }

    service { 'toxiproxy':
      ensure   => running,
      enable   => true,
      name     => $::toxiproxy::service_name,
      provider => $::toxiproxy::service_provider,
    }
  }
}
