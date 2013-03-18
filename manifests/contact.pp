
define nagios::contact(
	$email,
	$alias                         = false,
	$contactgroups                 = false,
	$can_submit_commands           = 0,
	$host_notifications_enabled    = false,
	$host_notification_period      = false,
	$service_notifications_enabled = false,
	$service_notification_period   = false,
	$host_notification_options     = false,
	$service_notification_options  = false,
	$host_notification_commands    = false,
	$service_notification_commands = false,
	$retain_status_information     = false,
	$retain_nonstatus_information  = false,
	$use                           = $nagios::params::template_contact,
	$username                      = false,
	$cryptpasswd                   = false,
	$ensure                        = present) {
	
	include nagios::params

	$contact_name = $name
	
	nagios_contact { $contact_name:
		ensure                        => $ensure,
		use                           => $use,
		contact_name                  => $contact_name,
		email                         => $email,
		target                        => $nagios::params::target_contact,
		alias                         => $alias ? {
							false   => undef,
							''      => undef,
							default => $alias,
							},
		contactgroups                 => $contactgroups ? {
							false   => undef,
							''      => undef,
							default => $contactgroups
							},
		host_notifications_enabled    => $host_notifications_enabled ? {
							false   => undef,
							''      => undef,
							default => $host_notifications_enabled
							},
		host_notification_period      => $host_notification_period ? {
							false   => undef,
							''      => undef,
							default => $host_notification_period
							},
		service_notifications_enabled => $service_notifications_enabled ? {
							false   => undef,
							''      => undef,
							default => $service_notifications_enabled
							},
		service_notification_period   => $service_notification_period ? {
							false   => undef,
							''      => undef,
							default => $service_notification_period
							},
		host_notification_options     => $host_notification_options ? {
							false   => undef,
							''      => undef,
							default => $host_notification_options
							},
		service_notification_options  => $service_notification_options ? {
							false   => undef,
							''      => undef,
							default => $service_notification_options
							},
		host_notification_commands    => $host_notification_commands ? {
							false   => undef,
							''      => undef,
							default => $host_notification_commands
							},
		service_notification_commands => $service_notification_commands ? { 
							false   => undef,
							''      => undef,
							default => $service_notification_commands
							},
		can_submit_commands           => $can_submit_commands ? {
							false   => undef,
							''      => undef,
							default => $can_submit_commands
							},
		retain_status_information     => $retain_status_information ? {
							false   => undef,
							''      => undef,
							default => $retain_status_information
							},
		retain_nonstatus_information  => $retain_nonstatus_information ? {
							false   => undef,
							''      => undef,
							default => $retain_nonstatus_information
							},
	}

	if(!$username) {
		$htuser = $contact_name
	}
	else {
		$htuser = $username
	}
	
	if(!$cryptpasswd) {
		fail("You must set cryptpasswd for user ${htuser}")
	}

	nagios::htpasswd { $htuser:
		cryptpasswd => $cryptpasswd,
		ensure      => $ensure,
		require     => Nagios_contact[$contact_name],
	}
}
