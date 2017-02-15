# Class to install and configure apache toxiproxy.
#
# Use this module to install and configure apache toxiproxy.
#
# @example Declaring the class
#   include ::toxiproxy
#
# @param config (String) toxiproxy config.
# @param config_file (String) toxiproxy config file.
# @param install_dir (String) Location of toxiproxy binary release.
# @param install_method (String) How to install toxiproxy.
# @param manage_service (Boolean) Manage the toxiproxy service.
# @param package_name (String) Name of package to install.
# @param package_version (String) Version of toxiproxy to install.
# @param service_name (String) Name of service to manage.
# @param service_provider (String) init system that is used.
# @param wget_source (String) Location of toxiproxy binary release.
class toxiproxy (
  $config           = $::toxiproxy::params::config,
  $config_file      = $::toxiproxy::params::config_file,
  $install_dir      = $::toxiproxy::params::install_dir,
  $install_method   = $::toxiproxy::params::install_method,
  $manage_service   = $::toxiproxy::params::manage_service,
  $package_name     = $::toxiproxy::params::package_name,
  $package_version  = $::toxiproxy::params::package_version,
  $service_name     = $::toxiproxy::params::service_name,
  $service_provider = $::toxiproxy::params::service_provider,
  $wget_source      = $::toxiproxy::params::wget_source,
) inherits toxiproxy::params {
  validate_bool(
    $manage_service,
  )
  validate_string(
    $config_file,
    $install_dir,
    $install_method,
    $package_name,
    $package_version,
    $service_name,
    $service_provider,
  )
  if $install_method == 'wget' {
    validate_string(
      $wget_source
    )
  }

  anchor { 'toxiproxy::begin': } ->
  class{ '::toxiproxy::install': } ->
  class{ '::toxiproxy::config': } ~>
  class{ '::toxiproxy::service': } ->
  anchor { 'toxiproxy::end': }
}
