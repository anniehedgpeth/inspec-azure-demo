# encoding: utf-8
# copyright: 2018, Annie Hedgpeth

title 'Sample InSpec Azure Controls'

control 'azurerm_virtual_machine' do
  describe azurerm_virtual_machine(resource_group: 'MyResourceGroup', name: 'prod-web-01') do
    it                                { should exist }
    it                                { should have_monitoring_agent_installed }
    it                                { should_not have_endpoint_protection_installed([]) }
    it                                { should have_only_approved_extensions(['MicrosoftMonitoringAgent']) }
    its('type')                       { should eq 'Microsoft.Compute/virtualMachines' }
    its('installed_extensions_types') { should include('MicrosoftMonitoringAgent') }
    its('installed_extensions_names') { should include('LogAnalytics') }
  end
end

control 'azure_network_security_group' do
  describe azure_network_security_group(resource_group: 'ProductionResourceGroup', name: 'ProdServers') do
    it                            { should exist }
    its('type')                   { should eq 'Microsoft.Network/networkSecurityGroups' }
    its('security_rules')         { should_not be_empty }
    its('default_security_rules') { should_not be_empty }
    it                            { should_not allow_rdp_from_internet }
    it                            { should_not allow_ssh_from_internet }
  end
end