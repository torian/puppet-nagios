
#	$display_name   = false,
#	$servicegroups  = false,
#	$is_volatile    = 0,
#	$initial_state  = 'u',
#	$max_check_attempts
#	$check_freshness
#	$freshness_threshold
#	$event_handler
#	$event_handler_enabled
#	$low_flap_threshold
#	$high_flap_threshold
#	$flap_detection_enabled
#	$flap_detection_options
#	$retain_status_information
#	$retain_nonstatus_information
#	$first_notification_delay
#	$stalking_options
#	$notes
#	$notes_url
#	$action_url
#	$icon_image
#	$icon_image_alt

define nagios::service($check_command,
	$service_description,
	$check_args             = false,
	$use                    = $nagios::params::template_service,
	$hostgroup_name         = false,
	$host_name              = false,
	$contact_groups         = false,
	$contacts               = false,
	$notifications_enabled  = true,
	$notification_interval  = false,
	$notification_period    = false,
	$notification_options   = false,
	$process_perf_data      = false,
	$check_period           = false,
	$retry_interval         = false,
	$active_checks_enabled  = false,
	$passive_checks_enabled = false,
	$obsess_over_service    = false,
	$nrpe                   = false,
	$nrpe_args              = false,
	$nrpe_timeout           = 10,
	$ensure                 = present) {
	
	include nagios::params
	
	if ($check_args != false) and ($check_args != '') {
		# cmnd_args should be in the form of "!arg1[!arg2][...]"
		$cmnd = "${check_command}${check_args}"
	} else {
		$cmnd = $check_command
	}
	
	@@nagios_service { "${service_description}::${::fqdn}":
		ensure              => $ensure,
		use                 => $use,
		check_command       => $cmnd,
		service_description => $service_description,
		target              => "${nagios::params::prefix_objects}/${client}-services.cfg",
		notify              => Service[$nagios::params::service],
		hostgroup_name      => $hostgroup_name ? {
						false   => undef,
						''      => '',
						default => $hostgroup_name
						},
		host_name           => $host_name ? {
						false   => undef,
						default => $host_name,
						}
	}

}
