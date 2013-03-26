
class nagios::params {

	$template_host    = 'tmpl_host'
	$template_service = 'tmpl_service'
	$template_contact = 'tmpl_contact'
	$contact_groups   = 'admins-linux'
	$host_check_cmnd  = 'check_alive'
	$nrpe_port        = '5666'

	case $::operatingsystem {
		
		debian: {
			
			$package        = 'nagios3'
			$pkg_addons     = [ 'nagios-nrpe-plugin' ]
			$service        = 'nagios3'
			$pattern        = 'nagios3'
			$owner          = 'nagios'
			$group          = 'nagios'
			$http_group     = 'www-data'
			$prefix         = '/etc/nagios3'
			$cfg            = "${prefix}/nagios.cfg"
			$prefix_objects = "${prefix}/puppet-conf.d"
			$htpasswd       = "${prefix}/htpasswd.users"
			$target_command = "${prefix_objects}/puppet-check-commands.cfg"
			$target_contact = "${prefix_objects}/puppet-contacts.cfg"
			$target_contactgroup = "${prefix_objects}/puppet-contactgroups.cfg"
		}
		
		redhat: {
			$package        = 'nagios3'
			$pkg_addons     = [ 'nagios-nrpe-plugin' ]
			$service        = 'nagios3'
			$pattern        = 'nagios3'
			$owner          = 'nagios'
			$group          = 'nagios'
			$http_group     = 'apache'
			$prefix         = '/etc/nagios3'
			$cfg            = "${prefix}/nagios.cfg"
			$prefix_objects = "${prefix}/conf.d"
			$htpasswd       = "${prefix}/htpasswd.users"
			$target_command = "${prefix_objects}/puppet-check-commands.cfg"
			$target_contact = "${prefix_objects}/puppet-contacts.cfg"
			$target_contactgroup = "${prefix_objects}/puppet-contactgroups.cfg"
		}
		
		oel: {
			# TODO
		}

		default: {
			fail("Operating system $::operatingsystem is not supported yet")
		}
		
	}	
}
