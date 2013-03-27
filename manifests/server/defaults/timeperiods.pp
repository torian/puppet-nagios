
class nagios::server::defaults::timeperiods {

	include nagios::params

	file { "${nagios::params::prefix_objects}/timeperiods.cfg":
		owner   => $nagios::params::owner,
		group   => $nagios::params::group,
		mode    => 0640,
		content => template('nagios/timeperiods.cfg.erb'),
		notify  => Service[$nagios::params::service],
		require => File[$nagios::params::prefix_objects]
	}

}
