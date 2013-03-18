
require 'spec_helper'

describe 'nagios' do

	opts = {
		'Debian' => {
			:package     => 'nagios3',
			:prefix      => '/etc/nagios3',
			:prefix_obj  => '/etc/nagios3/conf.d',
			:cfg         => '/etc/nagios3/nagios.cfg',
			:htpasswd    => '/etc/nagios3/htpasswd.users',
			:owner       => 'nagios',
			:group       => 'www-data',
			:http_group  => 'www-data',
		},

		#'Redhat' => {
		#	:package     => 'nagios3',
		#	:prefix      => '/etc/nagios3',
		#	:prefix_obj  => '/etc/nagios3/conf.d',
		#	:cfg         => '/etc/nagios3/nagios.cfg',
		#	:htpasswd    => '/etc/nagios3/htpasswd.users',
		#	:owner       => 'nagios',
		#	:group       => 'apache',
		#	:http_group  => 'apache',
		#}
	}

	opts.keys.each do |os|

		let(:facts) { {  :operatingsystem => os } }
		describe "Running on #{os}" do
			it { should include_class('nagios::params') }
			it { should include_class('nagios::server::export') }
			it { should contain_package(opts[os][:package]) }
			it { should contain_file(opts[os][:prefix]) }
			it { should contain_file(opts[os][:prefix_obj]) }
			it { should contain_file(opts[os][:cfg]) }
			it { 
				should contain_file(opts[os][:htpasswd]).with( {
					:owner => opts[os][:owner],
					:group => opts[os][:http_group],
					:mode  => '0640',
				} )
			}
			
			context 'With motd enabled' do
				let(:params) { { :enable_motd => true } }
				it { should contain_motd__register('nagios') }
			end
			
			context 'With motd disabled' do
				let(:params) { { :enable_motd => false} }
				it { should_not contain_motd__register('nagios') }
			end

			context 'With defaults enabled' do
				let(:params) { { :enable_defaults => true } }
				it { should include_class('nagios::server::defaults') }
			end
			
			context 'With motd disabled' do
				let(:params) { { :enable_defaults => false } }
				it { should_not include_class('nagios::server::defaults') }
			end
		end
	end

	context 'Running on unsupported OS' do
		let(:facts) { { :operatingsystem => 'unknown' } }
		it do
			expect {
				should include_class('nagios::params')
			}.to raise_error(Puppet::Error, /^Operating system.*/)
		end
	end
end
