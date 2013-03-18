
class nagios::server::defaults::template_service {

	include nagios::params

	file { "${nagios::params::prefix_objects}/template-service.cfg":
		owner   => $nagios::params::owner,
		group   => $nagios::params::group,
		mode    => 0640,
		content => template('nagios/template-service.cfg.erb'),
		notify  => Service[$nagios::params::service]
	}

}
