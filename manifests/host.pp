#	$2d_coords                = false,
#	$3d_coords                = false,
define nagios::host(
	$host_name                = $::fqdn,
	$alias                    = $::fqdn,
	$address                  = $::ipaddress,
	$use                      = false,
	$check_command            = false,
	$parents                  = false,
	$contacts                 = false,
	$contact_groups           = false,
	$hostgroups               = false,
	$initial_state            = false,
	$display_name             = false,
	$obsess_over_host         = false,
	$low_flap_threshold       = false,
	$high_flap_threshold      = false,
	$first_notification_delay = false,
	$notification_period      = false,
	$notification_options     = false,
	$notifications_enabled    = false,
	$stalking_options         = false,
	$notes                    = false,
	$notes_url                = false,
	$action_url               = false,
	$icon_image               = false,
	$icon_image_alt           = false,
	$vrml_image               = false,
	$statusmap_image          = false,
	$ensure                   = present) {
	
	include nagios::params

	@@nagios_host { "host::${host_name}":
		ensure    => $ensure,
		host_name => $host_name,
		alias     => $alias,
		address   => $address,
		target    => "${nagios::params::prefix_objects}/${client}-hosts.cfg",
		use       => $use ? {
				false   => $nagios::params::template_host,
				''      => $nagios::params::template_host,
				default => $use
				},
		parents   => $parents ? {
				false   => undef,
				''      => undef,
				default => $parents
			},
		contact_groups => $contact_groups ? {
				false   => undef,
				''      => undef,
				default => $contact_groups
				},
		hostgroups     => $hostgroups ? {
				false   => undef,
				''      => undef,
				default => $hostgroups
				}
	}

	@@nagios_hostextinfo { "hostextinfo::${host_name}":
		ensure          => $ensure,
		host_name       => $host_name,
		icon_image_alt  => $::operatingsystem,
		icon_image      => inline_template('base/<%= operatingsystem.downcase %>.png'),
		statusmap_image => inline_template('base/<%= operatingsystem.downcase %>.gd2'),
		vrml_image      => inline_template('<%= operatingsystem.downcase %>.png'),
		target          => "${nagios::params::prefix_objects}/${client}-extinfo.cfg",
	}
	
}

