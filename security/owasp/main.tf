# GOOGLE SECURITY POLICY
# See README in this module for details.

resource "google_compute_security_policy" "security_policy" {

  # The policy name, please follow policy naming convention.
  name     = var.policy_name
  project  = var.project_id
  provider = google
  #----------------------------------------
  # For Default Allow Rule
  #----------------------------------------

  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }

  rule {
    action   = "allow"
    priority = "20000"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Allow public access, but guard for OWASP top 10 rules"
  }

  dynamic "rule" {
    for_each = var.owasp_rules
    content {
      action   = rule.value.action
      priority = rule.value.priority
      preview  = rule.value.preview
      match {
        expr {
          expression = rule.value.expression
        }
      }
    }
  }

  rule {
    action   = "deny(403)"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = [
        "*"]
      }
    }
    description = "default rule"
  }
  lifecycle { ignore_changes = [adaptive_protection_config[0].layer_7_ddos_defense_config[0].rule_visibility] }
}
