
class nagios::server::defaults {

	include nagios::server::defaults::template_host
	include nagios::server::defaults::template_contact
	include nagios::server::defaults::template_service
	include nagios::server::defaults::commands
	include nagios::server::defaults::commands_notify
	include nagios::server::defaults::timeperiods
	
}
