variable "department_groups" {
  description = "Display names of the Azure AD security groups to create, one per department."
  type        = list(string)
  default = [
    "Cloud Engineers",
    "IAM Engineers",
    "Finance",
    "HR",
    "Sales",
    "Contractors",
    "Security Operations",
    "Developers"
  ]

  validation {
    condition     = length(var.department_groups) == length(toset(var.department_groups))
    error_message = "department_groups must not contain duplicate names."
  }
}

