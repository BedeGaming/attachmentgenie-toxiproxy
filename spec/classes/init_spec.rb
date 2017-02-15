require 'spec_helper'
describe 'toxiproxy' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context "config" do

        context 'with defaults for all parameters' do
          it { should contain_class('toxiproxy') }
          it { should contain_anchor('toxiproxy::begin').that_comes_before('Class[toxiproxy::Install]') }
          it { should contain_class('toxiproxy::install').that_comes_before('Class[toxiproxy::Config]') }
          it { should contain_class('toxiproxy::config').that_notifies('Class[toxiproxy::Service]') }
          it { should contain_class('toxiproxy::service').that_comes_before('Anchor[toxiproxy::end]') }
          it { should contain_anchor('toxiproxy::end') }
          it { should contain_package('toxiproxy') }
          it { should contain_service('toxiproxy') }
        end

      end
    end
  end
end
