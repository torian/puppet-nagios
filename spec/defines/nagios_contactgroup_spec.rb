
require 'spec_helper'

describe 'nagios::contactgroup' do

	opts = {
		'Debian' => {
			
		},
	}

	opts.keys.each do |os|
		let(:facts) { {
			:operatingsystem => os 
		} }
		let(:title) { 'admins' }
		
		describe "Running on #{os}" do
			it { should include_class('nagios::params') }
			
			context 'Without params' do
				let(:params) { {  } }
				it { should contain_nagios_contactgroup(title) }
			end
			
			context 'With description'  do
				let(:params) { { 
					:description   => 'Administradores',
				} }
				it { 
					should contain_nagios_contactgroup(title).with( { 
					} ) 
				}
			end
			
			context 'With description | members'  do
				let(:params) { { 
					:description   => 'Administradores',
					:members => 'lmaguna,dcinich',
				} }
				it { 
					should contain_nagios__contactgroup(title).with( {
					} ) 
				}
			end
			
			context 'With description | members | contactgroup_members'  do
				let(:params) { { 
					:description                => 'Administradores',
					:members              => 'ecastag,lmaguna,dcinich',
				} }
			end
		end
	end
end
