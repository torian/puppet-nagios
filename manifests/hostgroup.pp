
define nagios::hostgroup(
	$alias             = false,
	$members           = false,
	$hostgroup_members = false,
	$notes             = false,
	$notes_url         = false,
	$action_url        = false,
	$ensure            = present) {

	include nagios::params

	$hostgroup_name = $name

	if($alias == false) { $hostgroup_alias = $hostgroup_name }
	
	@@nagios_hostgroup { $hostgroup_name:
		hostgroup_name    => $hostgroup_name,
		alias             => $hostgroup_alias,
		target            => "${nagios::params::prefix_objects}/${client}-hostgroup.cfg",
		notes             => $notes? {
					false   => undef,
					''      => undef,
					default => $notes
					},
		notes_url         => $notes_url ? {
					false   => undef,
					''      => undef,
					default => $notes_url
					},
		action_url        => $action_url ? {
					false   => undef,
					''      => undef,
					default => $action_url
					},
		members            => $members ? {
					false   => undef,
					''      => undef,
					default => $members
					},
		hostgroup_members => $hostgroup_members ? {
					false   => undef,
					''      => undef,
					default => $hostgroup_members
					},
	}
}
