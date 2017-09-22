require 'spec_helper'
describe 'toxiproxy' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context 'install' do
        context 'with wget_source set to special_toxiproxy' do
          let(:params) do
            {
              install_method: 'wget',
              wget_source: 'special_toxiproxy'
            }
          end
          it { is_expected.to contain_wget__fetch('toxiproxy binary').with_source('special_toxiproxy') }
        end

        context 'with install_dir set to toxiproxy install dir' do
          let(:params) do
            {
              install_dir: '/opt/special',
              install_method: 'wget'
            }
          end
          it { is_expected.to contain_file('toxiproxy install dir').with_path('/opt/special') }
          it { is_expected.to contain_wget__fetch('toxiproxy binary').with_destination('/opt/special/toxiproxy') }
          it { is_expected.to contain_wget__fetch('toxiproxy binary').that_requires('File[toxiproxy install dir]') }
        end

        context 'with install_method set to package' do
          let(:params) do
            {
              install_dir: '/usr/bin',
              install_method: 'package',
              package_name: 'toxiproxy'
            }
          end
          it { is_expected.not_to contain_file('toxiproxy install dir').that_comes_before('Wget::Fetch[toxiproxy binary]') }
          it { is_expected.not_to contain_wget__fetch('toxiproxy binary') }
          it { is_expected.to contain_package('toxiproxy') }
        end

        context 'with install_method set to wget' do
          let(:params) do
            {
              install_dir: '/usr/bin',
              install_method: 'wget',
              package_name: 'toxiproxy'
            }
          end
          it { is_expected.to contain_file('toxiproxy install dir').that_comes_before('Wget::Fetch[toxiproxy binary]') }
          it { is_expected.to contain_wget__fetch('toxiproxy binary') }
          it { is_expected.to contain_file('toxiproxy binary') }
          it { is_expected.not_to contain_package('toxiproxy') }
        end

        context 'with package_name set to specialpackage' do
          let(:params) do
            {
              install_method: 'package',
              package_name: 'specialpackage'
            }
          end
          it { is_expected.to contain_package('toxiproxy').with_name('specialpackage') }
        end

        context 'with package_version set to 42.42.42' do
          let(:params) do
            {
              install_method: 'package',
              package_name: 'toxiproxy',
              package_version: '42.42.42'
            }
          end
          it { is_expected.to contain_package('toxiproxy').with_ensure('42.42.42') }
        end
      end
    end
  end
end
