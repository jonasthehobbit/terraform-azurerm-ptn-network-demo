package terraform.azure.tags

tags = ["environment", "owner", "costcode"]
import input.plan as tfplan
import rego.v1

# Rule to check for Azure Resource Groups and ensure they have tags
deny contains msg if {
	resource := tfplan.resource_changes[_]
	resource.type == "azurerm_resource_group"
	missing_tags := {tag | tag := tags[_]; not resource.change.after.tags[tag]}
	count(missing_tags) > 0
	msg := sprintf("Resource group is missing the following tags: %v", [missing_tags])
}