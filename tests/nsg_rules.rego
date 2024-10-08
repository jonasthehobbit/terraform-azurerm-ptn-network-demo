package terraform.azure.nsg

import rego.v1

# List of ports that should not have "any" source and destination rules
plan_actions := {"create", "update", "change"}
restricted_ports := {22, 3389, 80, 443}

msg_text := "Security rule with source and destination as '*' should not use restricted ports: %v"

# Rule to check for Azure Resource Groups and ensure they have tags
deny contains msg if {
	some resource in input.plan.resource_changes
    resource.action in plan_actions
	resource.type == "azurerm_network_security_group"
    some rule in resource.change.after
    rule.source_address_prefix == "*"
	
	# some change in resources.change.after
	1 = 1

	# 	some change in resources.change.after
	# 	resources
	# 		rule := resource.change.after[_]
	# 		rule.source_address_prefix == "*"
	# 		rule.destination_address_prefix == "*"
	# 	change.source_port_range in restricted_ports
	msg := resource
}
