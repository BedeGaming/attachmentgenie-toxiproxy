# Class to install and configure toxiproxy.
#
# Use this module to install and configure toxiproxy.
#
# @example Declaring the class
#   include ::toxiproxy
#
# @param install_dir Location of toxiproxy binary release.
# @param install_method How to install toxiproxy.
# @param manage_service Manage the toxiproxy service.
# @param package_name Name of package to install.
# @param package_version Version of toxiproxy to install.
# @param service_name Name of service to manage.
# @param service_provider Init system that is used.
# @param service_ensure The state of the service.
# @param wget_source Location of toxiproxy binary release.
class toxiproxy (
  String $install_dir = $::toxiproxy::params::install_dir,
  Enum['package','wget'] $install_method = $::toxiproxy::params::install_method,
  Boolean $manage_service = $::toxiproxy::params::manage_service,
  String $package_name = $::toxiproxy::params::package_name,
  String $package_version = $::toxiproxy::params::package_version,
  String $service_name = $::toxiproxy::params::service_name,
  String $service_provider = $::toxiproxy::params::service_provider,
  Enum['running','stopped'] $service_ensure = $::toxiproxy::params::service_ensure,
  Optional[String] $wget_source = $::toxiproxy::params::wget_source,
) inherits toxiproxy::params {
  anchor { 'toxiproxy::begin': }
  -> class{ '::toxiproxy::install': }
  ~> class{ '::toxiproxy::service': }
  -> anchor { 'toxiproxy::end': }
}
