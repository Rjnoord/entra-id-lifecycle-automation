output "department_group_ids" {
  description = "Object IDs of the created Azure AD department groups, keyed by display name."
  value       = { for name, group in azuread_group.departments : name => group.object_id }
}
