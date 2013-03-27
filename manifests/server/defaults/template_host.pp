
class nagios::server::defaults::template_host {

	include nagios::params

	file { "${nagios::params::prefix_objects}/template-host.cfg":
		owner   => $nagios::params::owner,
		group   => $nagios::params::group,
		mode    => 0640,
		content => template('nagios/template-host.cfg.erb'),
		notify  => Service[$nagios::params::service],
		require => File[$nagios::params::prefix_objects]
	}

	#nagios_host { 'tmpl_host':
	#	name                         => 'tmpl_host',
	#	target                       => "${nagios::params::prefix_objects}/template-host.cfg",
	#	check_command                => 'check_alive',
	#	check_interval               => 2,
	#	check_period                 => '24x7',
	#	max_check_attempts           => 4,
	#	retry_interval               => 1,
	#	check_freshness              => 1,
	#	#freshness_threshold          => ,
	#	active_checks_enabled        => 1,
	#	passive_checks_enabled       => 1,
	#	register                     => 0,
	#	notifications_enabled        => 1,
	#	notification_interval        => 0,
	#	notification_period          => '24x7',
	#	notification_options         => 'd,u,r',
	#	first_notification_delay     => 5,
	#	event_handler_enabled        => 1,
	#	#event_handler                => ,
	#	flap_detection_enabled       => 1,
	#	#flap_detection_options       => ,
	#	failure_prediction_enabled   => 1,
	#	process_perf_data            => 1,
	#	retain_status_information    => 1,
	#	retain_nonstatus_information => 1,
	#	#action_url                   => '/nagios/pnp/index.php/graph?host=$HOSTNAME$" class="tips" rel="/nagios/pnp/index.php/popup?host=$HOSTNAME$&srv=_HOST_"'
	#}
}
