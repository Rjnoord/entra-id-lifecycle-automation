output "department_group_names" {
  description = "Display names of the Entra ID security groups managed by Terraform."
  value       = sort([for group in azuread_group.departments : group.display_name])
}
