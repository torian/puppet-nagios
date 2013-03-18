
class nagios::server::export {

	# FIXME: surely there is a better way ...
	exec { "chown/chmod ${nagios::params::prefix_objects}":
		command => "find ${nagios::params::prefix_objects} -type f -not -user ${nagios::params::owner} -exec chmod 640 \{} \; -exec chown ${nagios::params::owner}: \{} \;"
	}

	Nagios_host <<||>> {
		require => File[$nagios::params::prefix_objects],
		notify  => [ 
			Service[$nagios::params::service],
			Exec["chown/chmod ${nagios::params::prefix_objects}"],
			],
	}
	Nagios_hostextinfo <<||>> { 
		require => File[$nagios::params::prefix_objects],
		notify  => [ 
			Service[$nagios::params::service],
			Exec["chown/chmod ${nagios::params::prefix_objects}"],
			],
	}
	Nagios_hostgroup   <<||>> {
		require => File[$nagios::params::prefix_objects],
		notify  => [ 
			Service[$nagios::params::service],
			Exec["chown/chmod ${nagios::params::prefix_objects}"],
			],
	}
	Nagios_service     <<||>> { 
		require => File[$nagios::params::prefix_objects],
		notify  => [ 
			Service[$nagios::params::service],
			Exec["chown/chmod ${nagios::params::prefix_objects}"],
			],
	}

}
