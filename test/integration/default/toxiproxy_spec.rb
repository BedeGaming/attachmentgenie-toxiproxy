control 'jobmanager 01' do
  impact 1.0
  title 'toxiproxy jobmanager service is running'
  desc 'Ensures that the toxiproxy jobmanager service is up and running'
  describe service('toxiproxy') do
    it { is_expected.to be_enabled }
    it { is_expected.to be_installed }
    it { is_expected.to be_running }
  end
end

control 'jobmanager 02' do
  impact 1.0
  title 'toxiproxy jobmanager service is listening at port 8474'
  desc 'Ensures that the toxiproxy jobmanager service is listening at port 8474'
  describe port(8474) do
    it { is_expected.to be_listening }
    its('processes') { is_expected.to include 'toxiproxy' }
    its('protocols') { is_expected.to include 'tcp' }
  end
end
