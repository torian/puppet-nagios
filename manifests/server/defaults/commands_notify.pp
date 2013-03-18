
class nagios::server::defaults::commands_notify {

	include nagios::params

	nagios_command { 'notify-host-email':
		target       => "${nagios::params::prefix_objects}/commands-notify.cfg",
		command_name => 'notify-host-email',
		command_line => '/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\nHost: $HOSTNAME$\nState: $HOSTSTATE$\nAddress: $HOSTADDRESS$\nInfo: $HOSTOUTPUT$\n\nDate/Time: $LONGDATETIME$\n" | /usr/bin/mail -s "** $NOTIFICATIONTYPE$ Host Alert: $HOSTNAME$ is $HOSTSTATE$ **" $CONTACTEMAIL$',
		notify => Exec["chown/chmod ${nagios::params::prefix_objects}"],
	}
	
	nagios_command { 'notify-service-email':
		target       => "${nagios::params::prefix_objects}/commands-notify.cfg",
		command_name => 'notify-service-email',
		command_line => '/usr/bin/printf "%b" "***** Nagios *****\n\nNotification Type: $NOTIFICATIONTYPE$\n\nService: $SERVICEDESC$\nHost: $HOSTALIAS$\nAddress: $HOSTADDRESS$\nState: $SERVICESTATE$\n\nDate/Time: $LONGDATETIME$\n\nAdditional Info:\n\n$SERVICEOUTPUT$" | /usr/bin/mail -s "** $NOTIFICATIONTYPE$ Service Alert: $HOSTALIAS$/$SERVICEDESC$ is $SERVICESTATE$ **" $CONTACTEMAIL$',
		notify => Exec["chown/chmod ${nagios::params::prefix_objects}"],
	}

}

