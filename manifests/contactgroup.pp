
define nagios::contactgroup(
	$description          = false,
	$members              = false,
	$contactgroup_members = false,
	$ensure               = present) {
	
	include nagios::params
	
	$contactgroup_name = $name

	nagios_contactgroup { $contactgroup_name:
		ensure               => $ensure,
		contactgroup_name    => $contactgroup_name,
		target               => $nagios::params::target_contactgroup,
		alias                => $description ? {
					false   => $contactgroup_name,
					''      => $contactgroup_name,
					default => $description
					},
		members              => $members ? {
					false   => undef,
					''      => undef,
					default => $members
					},
		contactgroup_members => $contactgroup_members ? {
					false   => undef,
					''      => undef,
					default => $contactgroup_members
					},
		notify               => Service[$nagios::params::service]
	}
}
