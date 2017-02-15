require 'spec_helper'
describe 'toxiproxy' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context "service" do

        context 'with manage_service set to true' do
          let(:params) {
            {
                :manage_service => true,
                :service_name   => 'toxiproxy'
            }
          }
          it { should contain_service('toxiproxy') }
        end

        context 'with manage_service set to false' do
          let(:params) {
            {
                :manage_service => false,
                :service_name   => 'toxiproxy'
            }
          }
          it { should_not contain_service('toxiproxy') }
        end

        context 'with service_name set to specialservice' do
          let(:params) {
            {
                :manage_service => true,
                :service_name   => 'specialservice',
            }
          }
          it { should contain_service('specialservice') }
        end

        context 'with service_name set to specialservice and with service_provider set to debian' do
          let(:params) {
            {
                :manage_service   => true,
                :service_name     => 'specialservice',
                :service_provider => 'debian',
            }
          }
          it { should contain_service('specialservice') }
          it { should contain_file('/etc/init.d/specialservice').that_notifies('Service[specialservice]').with_content(/^NAME="specialservice"/) }
        end

        context 'with service_name set to specialservice and with service_provider set to init' do
          let(:params) {
            {
                :manage_service   => true,
                :service_name     => 'specialservice',
                :service_provider => 'init',
            }
          }
          it { should contain_service('specialservice') }
          it { should contain_file('/etc/init.d/specialservice').that_notifies('Service[specialservice]').with_content(/^NAME="specialservice"/) }
        end

        context 'with service_name set to specialservice and with service_provider set to redhat' do
          let(:params) {
            {
                :manage_service   => true,
                :service_name     => 'specialservice',
                :service_provider => 'redhat',
            }
          }
          it { should contain_service('specialservice') }
          it { should contain_file('/etc/init.d/specialservice').that_notifies('Service[specialservice]').with_content(/^NAME="specialservice"/) }
        end

        context 'with service_name set to specialservice and with service_provider set to systemd' do
          let(:params) {
            {
                :manage_service   => true,
                :service_name     => 'specialservice',
                :service_provider => 'systemd',
            }
          }
          it { should contain_service('specialservice') }
          it { should contain_systemd__Unit_file('specialservice.service').that_comes_before('Service[specialservice]').with_content(/^Description=specialservice/) }
        end

        context 'with service_name set to specialservice and with install_method set to package' do
          let(:params) {
            {
                :install_method => 'package',
                :manage_service => true,
                :package_name   => 'toxiproxy',
                :service_name   => 'specialservice',
            }
          }
          it { should contain_service('specialservice').that_subscribes_to('Package[toxiproxy]') }
        end

        context 'with service_provider set to init' do
          let(:params) {
            {
                :manage_service   => true,
                :service_name     => 'toxiproxy',
                :service_provider => 'init',
            }
          }
          it { should contain_file('/etc/init.d/toxiproxy') }
          it { should_not contain_systemd__Unit_file('toxiproxy.service').that_comes_before('Service[toxiproxy]') }
          it { should contain_service('toxiproxy') }
        end

        context 'with service_provider set to systemd' do
          let(:params) {
            {
                :manage_service   => true,
                :service_name     => 'toxiproxy',
                :service_provider => 'systemd',
            }
          }
          it { should_not contain_file('/etc/init.d/toxiproxy') }
          it { should contain_systemd__Unit_file('toxiproxy.service').that_comes_before('Service[toxiproxy]') }
          it { should contain_service('toxiproxy') }
        end

        context 'with service_provider set to invalid' do
          let(:params) {
            {
                :manage_service   => true,
                :service_provider => 'invalid',
            }
          }
          it { should raise_error(/Service provider invalid not supported/) }
        end

      end
    end
  end
end
