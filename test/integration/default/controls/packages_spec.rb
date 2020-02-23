# frozen_string_literal: true

# Overide by OS
package_name = 'auditbeat'
package_name = 'filebeat'
package_name = 'heartbeat'
package_name = 'journalbeat'
package_name = 'metricbeat'
package_name = 'packetbeat'

control 'beats package' do
  title 'should be installed'

  describe package(package_name) do
    it { should be_installed }
  end
end
