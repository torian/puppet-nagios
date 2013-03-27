#
# nagios::nrpe::check_command { 'check_procs_state':
# 	plugin => 'check_procs',
#	args   => '-w $ARG1$ -c $ARG2$ -s $ARG3$'
# }
#
define nagios::nrpe::check_command(
	$plugin, 
	$args    = '',
	$order   = 1,
	$ensure  = present) {

	include nagios::params

	$cmd_template = "command[<%= name %>]=<%= plugins_dir %>/<%= plugin %> <%= args %>"

	concat::fragment { "nagios::nrpe::check_command ${name} fragment":
		ensure  => $ensure,
		target  => $nagios::params::nrpe_cfg,
		content => template($cmd_template),
		order   => $order,
	}
}
