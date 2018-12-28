# encoding: utf-8
# copyright: 2018, Annie Hedgpeth

title 'Sample InSpec Azure Controls'

resource_group = 'my-resources'

control 'azurerm_virtual_machine' do
  describe azurerm_virtual_machine(resource_group: resource_group, name: 'my-vm') do
    it                                { should exist }
    its('type')                       { should eq 'Microsoft.Compute/virtualMachines' }
  end
end

control 'azure_network_security_group' do
  describe azure_network_security_group(resource_group: resource_group, name: 'nsg') do
    it                            { should exist }
    its('type')                   { should eq 'Microsoft.Network/networkSecurityGroups' }
    its('security_rules')         { should_not be_empty }
    its('default_security_rules') { should_not be_empty }
    it                            { should_not allow_rdp_from_internet }
    it                            { should_not allow_ssh_from_internet }
  end
end

control 'azure_network_security_group' do
  describe azurerm_virtual_network(resource_group: resource_group, name: 'my-network') do
    it               { should exist }
    its('location')  { should eq 'Central US' }
  end
end