# frozen_string_literal: true

control 'beats configuration' do
  title 'should match desired lines'

  describe file('/etc/auditbeat/auditbeat.yml') do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    its('mode') { should cmp '0644' }
    its('content') do
      should include(
        '"filebeat.prospectors":'\
        '"-input_type: log'\
        'paths:'\
        '- /var/log/*.log'
      )
    its('content') do
      should include(
        'output.elasticsearch:'\
        'hosts: ["localhost:9200"]'
      )
    end
  end
end
