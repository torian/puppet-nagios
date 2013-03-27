# Class: nagios
#
#
#   Emiliano Castagnari (torian) <ecastag@gmail.com>
#   2013/02/21
#
# Tested platforms:
#
#	TODO  
#
# Parameters:
#
#	TODO
#
# Requires:
#
#
# Sample Usage:
#
# 
class nagios(
	$enable_defaults = true,
	$enable_motd     = true,
	$external_cmd    = false,
	$ensure          = present) {
	
	include nagios::params
	
	# If motd is enabled, register the presence of
	# this module
	# Requires:
	#  https://github.com/torian/puppet-motd
	#  https://github.com/ripienaar/puppet-concat
	if($enable_motd) {
		motd::register { 'nagios': }
	}

	package { $nagios::params::package:
		ensure => $ensure
	}

	service { $nagios::params::service:
		name       => $nagios::params::service,
		pattern    => $nagios::params::pattern,
		hasstatus  => true,
		hasrestart => true,
		require    => [ 
				Package[$nagios::params::package], 
				Exec["chown/chmod ${nagios::params::prefix_objects}"],
				],
		ensure     => $ensure ? {
				'present' => 'running',
				default   => 'stopped',
				},
		enable     => $ensure ? {
				'present' => true,
				default   => false,
				},
	}

	File {
		owner  => $nagios::params::owner,
		group  => $nagios::params::group,
	}

	file { $nagios::params::prefix:
		ensure  => $ensure ? {
				present => directory,
				default => absent,
				},
		mode    => 2755,
		require => Package[$nagios::params::package],
	}

	file { $nagios::params::prefix_objects:
		ensure  => $ensure ? {
				present => directory,
				default => absent,
				},
		mode    => 2750,
		require => File[$nagios::params::prefix],
	}

	file { $nagios::params::cfg:
		ensure  => $ensure,
		group   => $nagios::params::http_group,
		mode    => 0640,
		content => template('nagios/nagios.cfg.erb'),
		require => File[$nagios::params::prefix],
		notify  => Service[$nagios::params::service],
	}
	
	file { $nagios::params::htpasswd:
		ensure  => $ensure,
		owner   => $nagios::params::owner,
		group   => $nagios::params::http_group,
		mode    => 0640,
		require => File[$nagios::params::prefix],
	}

	# Load exported resources
	include nagios::server::export
	
	if($enable_defaults) { include nagios::server::defaults }

}
