variable "department_groups" {
  description = "Department security groups managed in Microsoft Entra ID."
  type        = list(string)
  default = [
    "Cloud Engineers",
    "IAM Engineers",
    "Finance",
    "HR",
    "Sales",
    "Contractors"
  ]
}
