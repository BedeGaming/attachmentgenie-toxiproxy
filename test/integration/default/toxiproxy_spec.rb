control 'jobmanager 01' do
  impact 1.0
  title 'toxiproxy jobmanager service is running'
  desc 'Ensures that the toxiproxy jobmanager service is up and running'
  describe service('toxiproxy') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

control 'jobmanager 02' do
  impact 1.0
  title 'toxiproxy jobmanager service is listening at port 8474'
  desc 'Ensures that the toxiproxy jobmanager service is listening at port 8474'
  describe port(8474) do
    it { should be_listening }
    its('processes') { should include 'toxiproxy'}
    its('protocols') { should include 'tcp' }
  end
end
