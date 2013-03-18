
class nagios::server::defaults::commands {

	include nagios::params

	nagios::command { 'check_nrpe':
		command_line => 'check_nrpe',
		command_args => "-H \$HOSTADDRESS$ -p ${nagios::params::nrpe_port}"
	}
	
	nagios::command { 'check_alive':
		command_line => 'check_ping',
		command_args => '-H $HOSTADDRESS$ -p 4 -w 4000.0,50% -c 6000.0,100%'
	}
	
	nagios::command { 'check_ping':
		command_line => 'check_ping',
		command_args => '-H $HOSTADDRESS$ -p $ARG1$ -w $ARG2$ -c $ARG3$'
	}

	nagios::command { 'check_procs':
		command_line => 'check_nrpe',
		command_args => "-H \$HOSTADDRESS$ -p ${nagios::params::nrpe_port} -c check_procs -a \$ARG1$ \$ARG2$"
	}
	
	nagios::command { 'check_disk':
		command_line => 'check_nrpe',
		command_args => "-H \$HOSTADDRESS$ -p ${nagios::params::nrpe_port} -c check_disk -a 10% 5% \$ARG1$"
	}
	
	nagios::command { 'check_disk_args':
		command_line => 'check_nrpe',
		command_args => "-H \$HOSTADDRESS$ -p ${nagios::params::nrpe_port} -c check_disk -a \$ARG1$ \$ARG2$ \$ARG3$"
	}
	
	nagios::command { 'check_ssh':
		command_line => 'check_ssh',
		command_args => '-H $HOSTADDRESS$'
	}

	nagios::command { 'check_ssh_port':
		command_line => 'check_ssh',
		command_args => '-H $HOSTADDRESS$ -p $ARG1$'
	}

	nagios::command { 'check_http':
		command_line => 'check_http',
		command_args => '-t 20 -H $ARG1$'
	}
	
	nagios::command { 'check_http_url':
		command_line => 'check_http',
		command_args => '-t 20 -H $ARG1$ -u $ARG2$'
	}
	
	nagios::command { 'check_http_port_url':
		command_line => 'check_http',
		command_args => '-t 20 -H $ARG1$ -u $ARG2$ -p $ARG3$'
	}
	
}

