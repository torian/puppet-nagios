
class nagios::server::defaults::template_contact {

	include nagios::params

	file { "${nagios::params::prefix_objects}/template-contact.cfg":
		owner   => $nagios::params::owner,
		group   => $nagios::params::group,
		mode    => 0640,
		content => template('nagios/template-contact.cfg.erb'),
		notify  => Service[$nagios::params::service],
		require => File[$nagios::params::prefix_objects]
	}

	# FIXME: naginator doesn't use the namevar as name, but as
	# host_name. Skip nagios_contact for template until then
	#nagios_contact { 'tmpl_contact':
	#	name                          => 'tmpl_contact',
	#	host_name                     => 'tmpl_contact',
	#	register                      => 0,
	#	host_notification_period      => '24x7',
	#	host_notification_options     => 'd,u,r',
	#	host_notification_commands    => 'notify-host-email',
	#	service_notification_period   => '24x7',
	#	service_notification_options  => 'u,w,c,r',
	#	service_notification_commands => 'notify-service-email,notify-service-rss',
	#	target                        => "${nagios::params::prefix_objects}/template-contact.cfg",
	#	notify => Exec["chown/chmod ${nagios::params::prefix_objects}"],
	#}
}
