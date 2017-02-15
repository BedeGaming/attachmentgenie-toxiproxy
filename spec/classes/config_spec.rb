require 'spec_helper'
describe 'toxiproxy' do
  on_os_under_test.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      context "config" do

      end
    end
  end
end
