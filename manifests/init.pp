# Class: gpp-node
#
# This class installs a REDHAWK GPP Node
#
# Parameters:
#
# Actions:
#   - Install REDHAWK GPP Node
#   - Manage GPP service
#
# Requires:
#
# Sample Usage:
#
class gpp_node (
  $node_name        = 'my-gpp-node',
  $node_num         = 1,
  $service_enable   = true,
  $service_ensure   = 'present',
  $manage_user      = false,
  $manage_group     = false,
) {
  # true/false is sufficient for both ensure and enable
  validate_bool($service_enable)

  # declare the web server user and group
  # Note: requiring the package means the package ought to create them and not puppet
  validate_bool($manage_user)
  if $manage_user {
    user { $user:
      ensure  => present,
      gid     => $group,
      require => Package['my-gpp-node'],
    }
  }
  validate_bool($manage_group)
  if $manage_group {
    group { $group:
      ensure  => present,
      require => Package['my-gpp-node']
    }
  }

  package { 'my-gpp-node':
    ensure => present,
  }
}
