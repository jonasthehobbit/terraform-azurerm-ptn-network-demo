package terraform.azure.nsg

# List of ports that should not have "any" source and destination rules
restricted_ports = [22, 3389, 80, 443]
import input.plan as tfplan
import rego.v1

# Rule to check for Azure Network Security Groups and ensure they do not have risky rules
deny contains msg if {
    resource := tfplan.resource_changes[_]
    resource.type == "azurerm_network_security_group"
    risky_rules_found := {rule | rule := resource.change.after.security_rules[_]; rule.access == "Allow" and rule.source_address_prefix == "*" and rule.destination_address_prefix == "*" and rule.destination_port_range in restricted_ports}
    count(risky_rules_found) > 0
    msg := sprintf("Network Security Group has risky rules for restricted ports: %v", [risky_rules_found])
}