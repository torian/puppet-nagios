
require 'spec_helper'

describe 'nagios::host' do

	let(:title) { 'host' }
	let(:node)  { 'sigma' }
	let(:facts) { { 
		:operatingsystem => 'Debian',
		:fqdn            => 'host'
	} }
	
	it { should include_class('nagios::params') }
	
	[ 'present', 'absent' ].each do |e|
		context 'Simple usage' do
		end
	end
end
