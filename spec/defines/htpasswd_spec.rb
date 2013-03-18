
require 'spec_helper'

describe 'nagios::htpasswd' do

	opts = {
		'Debian' => {
			:htpasswd => '/etc/nagios3/htpasswd.users',
			:owner    => 'nagios',
			:group    => 'www-data',
		},
	}

	opts.keys.each do |os|
		
		describe "Running on #{os}" do
			let(:facts)  { { :operatingsystem => os } }
			let(:params) { { 
				:cryptpasswd   => 'e/D98/sXInnWk',
			} }
			let(:title)  { 'nagiosadmin' }
			
			context 'With ensure == present' do
				it { should include_class('nagios::params') }
				it { should contain_exec("nagios::htpasswd #{title}")}
			end
		end
	end
end

