
define nagios::htpasswd(
	$cryptpasswd,
	$ensure      = present) {
	
	include nagios::params
	
	$username = $name

	# cryptpasswd can be generated with
	# mkpasswd -m des password
	exec { "nagios::htpasswd ${username}":
		command => "/usr/bin/htpasswd -bp ${nagios::params::htpasswd} ${username} ${cryptpasswd}",
		unless  => "/bin/egrep -q '^${username}:${cryptpasswd}' ${nagios::params::htpasswd}",
		require => File[$nagios::params::htpasswd]
	}
}
