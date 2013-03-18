
define nagios::command(
	$command_line,
	$command_args = false,
	$target       = false,
	$prefix       = '$USER1$',
	$ensure       = present) {
	
	include nagios::params
	
	$command_name = $name
	
	if ($command_args == false) {
		$command = "\$USER1$/$command_line"
	} else {
		$command = "\$USER1$/$command_line ${command_args}"
	}
	
	if ($target) { 
		$target_file = $target
	} else {
		$target_file = $nagios::params::target_command
	}
	
	nagios_command { $command_name:
		ensure       => $ensure,
		command_name => $command_name,
		command_line => $command,
		target       => $target_file,
	}
}

