package terraform.azure.tags

import input.plan as tfplan
import rego.v1
# filters for the plan actions
tags := {"environment", "owner", "costcode"}
resource_types = {"azurerm_resource_group"}
actions = {"create", "update"}
# Rule to check for Azure Resources and ensure they have the listed tags
deny contains msg if {
	some resource in tfplan.resource_changes
    address := resource.address
	resource.type in resource_types
    resource.change.actions[_] in actions
	missing_tags := {tag | tag := tags[_]; not resource.change.after.tags[tag]}
	count(missing_tags) > 0
	msg := sprintf("%s is missing the following tags: %v", [address, missing_tags])
}