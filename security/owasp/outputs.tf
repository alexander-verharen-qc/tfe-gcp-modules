
output "policy_self_link" {
  description = "The link to the policy"
  value       = try(google_compute_security_policy.security_policy.self_link)
}

output "policy_name" {
  description = "The name of the policy"
  value       = google_compute_security_policy.security_policy.name
}
