require 'spec_helper'
describe 'toxiproxy' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context 'config' do
        context 'with defaults for all parameters' do
          it { is_expected.to contain_class('toxiproxy') }
          it { is_expected.to contain_class('toxiproxy::params') }
          it { is_expected.to contain_anchor('toxiproxy::begin').that_comes_before('Class[toxiproxy::Install]') }
          it { is_expected.to contain_class('toxiproxy::install').that_comes_before('Class[toxiproxy::Service]') }
          it { is_expected.to contain_class('toxiproxy::service').that_comes_before('Anchor[toxiproxy::end]') }
          it { is_expected.to contain_anchor('toxiproxy::end') }
          it { is_expected.to contain_package('toxiproxy') }
          it { is_expected.to contain_service('toxiproxy') }
        end
      end
    end
  end
end
