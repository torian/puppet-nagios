# Class: nagios:nrpe
#
#   Install and configure Nagios NRPE client
#
#   Emiliano Castagnari (torian) <ecastag@gmail.com>
#   2013/02/21
#
# Tested platforms:
#
#	Debian: Squeeze / Wheezy
#
# Parameters:
#
#	allowed_hosts: Set the allowed_hosts parameter in nrpe.cfg
#	enable_motd:   Add '- nagios::nrpe' to motd
#	ensure:        present / absent
#
# Requires:
#
#	- puppet-concat (concat) - https://github.com/ripienaar/puppet-concat
#
#	- If you set enable_motd to true:
#	  puppet-motd   (motd)   - https://github.com/torian/puppet-motd
#
# Sample Usage:
#
#	class { 'nagios::nrpe':
#		allowed_hosts => [ 'localhost', '1.2.3.4' ]
#	 } 
#
# Or let hiera define some defaults
#
#	class { 'nagios::nrpe':
#		enable_motd => true
#	} 
#
class nagios::nrpe(
	$allowed_hosts      = hiera('allowed_hosts',      [ 'localhost' ]),
	$server_port        = hiera('server_port',        5666),
	$dont_blame_nrpe    = hiera('dont_blame_nrpe',    0),
	$command_timeout    = hiera('command_timeout',    30),
	$connection_timeout = hiera('connection_timeout', 60),
	$pid_file           = hiera('pid_file',           $nagios::params::nrpe_pidfile),
	$enable_motd        = hiera('enable_motd',        false),
	$ensure             = present) {
	
	include nagios::params
	
	if($enable_motd) {
		motd::register{ 'nagios::nrpe': }
	}
	
	package { $nagios::params::package_nrpe:
		ensure => $ensure,
	}
	
	file { $nagios::params::nrpe_prefix:
		ensure  => $ensure ? {
				present => directory,
				default => absent
				},
		owner   => $nagios::params::nrpe_owner,
		group   => $nagios::params::nrpe_group,
		mode    => 0750,
		require => Package[$nagios::params::package_nrpe]
	}
	
	concat { $nagios::params::nrpe_cfg:
		owner   => $nagios::params::nrpe_owner,
		group   => $nagios::params::nrpe_group,
		mode    => 0640,
		notify  => Service[$nagios::params::nrpe_service],
	}

	concat::fragment { "nagios::nrpe cfg":
		ensure  => $ensure,
		target  => $nagios::params::nrpe_cfg,
		content => template('nagios/nrpe.cfg.erb'),
		order   => 0,
	}
	
	service { $nagios::params::nrpe_service:
		name       => $nagios::params::nrpe_service,
		pattern    => $nagios::params::nrpe_pattern,
		hasstatus  => true,
		hasrestart => true,
		require    => File[$nagios::params::nrpe_cfg],
		ensure     => $ensure ? {
				present => running,
				default => stopped,
				},
		enable     => $ensure ? {
				present => true,
				default => false,
				},
	}
}
