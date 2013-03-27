
require 'spec_helper'

describe 'nagios::nrpe' do

	opts = {
		'Debian' => {
			:prefix  => '/etc/nagios',
			:cfg     => '/etc/nagios/nrpe.cfg',
			:package => 'nagios-nrpe-server',
			:service => 'nagios-nrpe-server',
		},
		
		'Redhat' => {
			:prefix  => '/etc/nagios',
			:cfg     => '/etc/nagios/nrpe.cfg',
			:package => 'nrpe',
			:service => 'nrpe',
		},
	}

	opts.keys.each do |os|
		let(:facts) { { 
			:operatingsystem => os,
			:concat_basedir  => '/var/lib/puppet/concat',
		} }
		describe "Running on #{os}" do
			it { should include_class('nagios::params') }
			if opts[os][:package].kind_of?(Array)
				opts[os][:package].each { |p|
					it { should contain_package(p) }
				}
			else
				it { should contain_package(opts[os][:package]) }
			end
			it { should contain_file(opts[os][:prefix]) }
			it { 
				should contain_concat__fragment('nagios::nrpe cfg').with ( {
					:target => opts[os][:cfg],
					:order  => 0,
				} )
			}
			it { should contain_service(opts[os][:service]) }
		end
	end
end
