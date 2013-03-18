# Class: nagios::server
#
#
#   Emiliano Castagnari (torian) <ecastag@gmail.com>
#   2013/02/21
#
# Tested platforms:
#
#	TODO  
#
# Parameters:
#
#	TODO
#
# Requires:
#
#
# Sample Usage:
#
# 
class nagios::server(
	$enable_defaults = true,
	$ensure          = present) {

	include nagios::params
	

}
