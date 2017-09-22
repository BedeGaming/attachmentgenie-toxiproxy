require 'spec_helper'
describe 'toxiproxy' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context 'service' do
        context 'with manage_service set to true' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'toxiproxy'
            }
          end
          it { is_expected.to contain_service('toxiproxy') }
        end

        context 'with manage_service set to false' do
          let(:params) do
            {
              manage_service: false,
              service_name: 'toxiproxy'
            }
          end
          it { is_expected.not_to contain_service('toxiproxy') }
        end

        context 'with service_name set to specialservice' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice'
            }
          end
          it { is_expected.to contain_service('toxiproxy').with_name('specialservice') }
        end

        context 'with service_name set to specialservice and with service_provider set to debian' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'debian'
            }
          end
          it { is_expected.to contain_service('toxiproxy').with_name('specialservice') }
          it { is_expected.to contain_file('toxiproxy service file').that_notifies('Service[specialservice]').with_content(%r{^NAME="specialservice"}) }
        end

        context 'with service_name set to specialservice and with service_provider set to init' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'init'
            }
          end
          it { is_expected.to contain_service('toxiproxy').with_name('specialservice') }
          it { is_expected.to contain_file('toxiproxy service file').that_notifies('Service[specialservice]').with_content(%r{^NAME="specialservice"}) }
        end

        context 'with service_name set to specialservice and with service_provider set to redhat' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'redhat'
            }
          end
          it { is_expected.to contain_service('toxiproxy').with_name('specialservice') }
          it { is_expected.to contain_file('toxiproxy service file').that_notifies('Service[specialservice]').with_content(%r{^NAME="specialservice"}) }
        end

        context 'with service_name set to specialservice and with service_provider set to systemd' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'specialservice',
              service_provider: 'systemd'
            }
          end
          it { is_expected.to contain_service('toxiproxy').with_name('specialservice') }
          it { is_expected.to contain_systemd__Unit_file('specialservice.service').that_comes_before('Service[specialservice]').with_content(%r{^Description=specialservice}) }
        end

        context 'with service_name set to specialservice and with install_method set to package' do
          let(:params) do
            {
              install_method: 'package',
              manage_service: true,
              package_name: 'toxiproxy',
              service_name: 'specialservice'
            }
          end
          it { is_expected.to contain_service('toxiproxy').that_subscribes_to('Package[toxiproxy]') }
        end

        context 'with service_provider set to init' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'toxiproxy',
              service_provider: 'init'
            }
          end
          it { is_expected.to contain_file('toxiproxy service file') }
          it { is_expected.not_to contain_systemd__Unit_file('toxiproxy.service').that_comes_before('Service[toxiproxy]') }
          it { is_expected.to contain_service('toxiproxy') }
        end

        context 'with service_provider set to systemd' do
          let(:params) do
            {
              manage_service: true,
              service_name: 'toxiproxy',
              service_provider: 'systemd'
            }
          end
          it { is_expected.not_to contain_file('toxiproxy service file') }
          it { is_expected.to contain_systemd__Unit_file('toxiproxy.service').that_comes_before('Service[toxiproxy]') }
          it { is_expected.to contain_service('toxiproxy') }
        end

        context 'with service_provider set to invalid' do
          let(:params) do
            {
              manage_service: true,
              service_provider: 'invalid'
            }
          end
          it { is_expected.to raise_error(%r{Service provider invalid not supported}) }
        end
      end
    end
  end
end
