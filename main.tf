resource "azuread_group" "departments" {
  for_each = toset(var.department_groups)

  display_name     = each.value
  security_enabled = true

}




