# inspec-azure-demo

Documentation: https://github.com/inspec/inspec-azure

## Prerequisites

 - InSpec is [installed](https://www.inspec.io/downloads/)
 - an Azure service principal with contributor rights
 - a .azure/credentials file in your home directory (see ["SETTING UP THE AZURE CREDENTIALS FILE"](https://www.inspec.io/docs/reference/platforms/))
 - Ruby
 - Bundler installed

## Why would I need this:
In order to validate Azure resources, we can use the inspec-azure gem to run automated tests against Azure.

## What InSpec shows in this demo:

1. InSpec is running locally against your Azure subscription. 

2. It is validating that your subscription is in the state in which it is expected to be in as defined by the InSpec profile.

## What to do:

Were just going to run a quick profile to show what it looks like and how quickly it tests the resources in your subscription. These are expected to fail, but you can see what kinds of tests are being run.

NOTE: This is not making any changes to your subscription.

1. From the command line of your choice, run this command from any directory.

```
inspec exec https://github.com/anniehedgpeth/inspec-azure-demo.git -t azure://[your-azure-subscription-id-here]
```

When you run this command, InSpec is querying your local machine to see if it's in the desired state that is specified in the InSpec profile. It will not be, and therefore you will see many many errors, which is what you want.

Your output will likely look like the following, mostly failures with a few passing tests. This is truncated:

```
Profile: InSpec Azure Demo (inspec-azure-demo)
Version: 0.1.0
Target:  azure://09f2ee05-2cb0-4996-a24e-b4d3083b0cbd

  ×  azurerm_virtual_machine: '' Virtual Machine (5 failed)
     ×  '' Virtual Machine should exist
     expected '' Virtual Machine to exist
     ×  '' Virtual Machine should have monitoring agent installed
     undefined method `osProfile' for nil:NilClass
     ✔  '' Virtual Machine should not have endpoint protection installed []
     ✔  '' Virtual Machine should have only approved extensions ["MicrosoftMonitoringAgent"]
     ×  '' Virtual Machine type should eq "Microsoft.Compute/virtualMachines"

     expected: "Microsoft.Compute/virtualMachines"
          got: nil

     (compared using ==)

     ×  '' Virtual Machine installed_extensions_types should include "MicrosoftMonitoringAgent"
     expected [] to include "MicrosoftMonitoringAgent"
     ×  '' Virtual Machine installed_extensions_names should include "LogAnalytics"
     expected [] to include "LogAnalytics"
  ×  azure_network_security_group: '' Network Security Group (6 failed)
     ×  '' Network Security Group should exist
     expected '' Network Security Group to exist
     ×  '' Network Security Group should not allow rdp from internet
     undefined method `[]' for nil:NilClass
     ×  '' Network Security Group should not allow ssh from internet
     undefined method `[]' for nil:NilClass
     ×  '' Network Security Group type should eq "Microsoft.Network/networkSecurityGroups"

     expected: "Microsoft.Network/networkSecurityGroups"
          got: nil

     (compared using ==)

     ×  '' Network Security Group security_rules
     undefined method `[]' for nil:NilClass
     ×  '' Network Security Group default_security_rules
     undefined method `[]' for nil:NilClass


Profile: Azure Resource Pack (inspec-azure)
Version: 1.2.0
Target:  azure://09f2ee05-2cb0-4996-a24e-b4d3083b0cbd

     No tests executed.

Profile Summary: 0 successful controls, 2 control failures, 0 controls skipped
Test Summary: 2 successful, 11 failures, 0 skipped
```