# frozen_string_literal: true

# Overide by OS
service_name = 'auditbeat'
service_name = 'filebeat'
service_name = 'heartbeat'
service_name = 'journalbeat'
service_name = 'metricbeat'
service_name = 'packetbeat'

control 'beats service' do
  impact 0.5
  title 'should be running and enabled'

  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end
end
