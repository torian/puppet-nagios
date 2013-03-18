
require 'spec_helper'

describe 'nagios::contact' do

	opts = {
		'Debian' => {
			
		},
	}

	opts.keys.each do |os|
		let(:facts) { { :operatingsystem => os } }

		describe "Running on #{os}" do
			let(:title) { 'torian' }
			
			context 'With email | cryptpasswd | alias' do
				let(:params) { { 
					:email        => 'torian@/dev/null',
					:cryptpasswd  => 'CymLuiAHtYsAI',
					:alias        => 'Emiliano Castagnari',
				} }
				it { should include_class('nagios::params') }
				it { 
					should contain_nagios_contact(title).with( {
						:email => params[:email],
						:alias => params[:alias],
					} )
				}
				it { 
					should contain_nagios__htpasswd(title).with( {
						:cryptpasswd => params[:cryptpasswd]
					} ) 
				}

			end
			
			context 'With email | cryptpasswd | username' do
				let(:params) { { 
					:email        => 'torian@/dev/null',
					:cryptpasswd  => 'CymLuiAHtYsAI',
					:username     => 'torian',
				} }
				it { should include_class('nagios::params') }
				it { 
					should contain_nagios_contact(title).with( {
						:email => params[:email],
					} )
				}
				it { should contain_nagios__htpasswd(params[:username]) }
			end

			context 'Without cryptpasswd' do
				let(:params) { { 
					:email        => 'torian@/dev/null',
				} }
				it { expect {
						should contain_nagios__htpasswd(title)
					}.to raise_error(Puppet::Error, /You must set .*/)
				}
			end
		
			context 'Without email' do
			end
			
			context 'Without params' do
				let(:params) { { } }
				it { expect {
						should contain_nagios__htpasswd(title).with()
					}.to raise_error(Puppet::Error)
				}
			end
		end
	end
end
