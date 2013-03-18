Puppet Nagios Module
====================

	TODO

Introduction
------------
 
 TODO

Examples
--------

Configure a node as a nagios server:

	node nagios.example.com {
		
		class { 'nagios': }
		
	}

FIXME more doc ...

Notes
-----

	TODO
	
Issues
------

 * Config files should be set by hand (TODO)
 
TODO
----

 * Manage cgi.cfg
 * Host / Service dependencies
 * Host / Service escalation

CopyLeft
---------

Copyleft (C) 2013 Emiliano Castagnari <ecastag@gmail.com> (a.k.a. Torian)
