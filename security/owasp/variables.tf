
variable "policy_name" {
  description = "The name of the policy. this field is required."
  type        = string
}
variable "project_id" {
  type = string
}

variable "owasp_rules" {
  description = "Ruleset for OWASP-10 Web Application Filtering, easily maintained in this variable set"
  default = {
    rule_sqli = {
      action           = "deny(403)"
      priority         = "1010"
      preview          = false
      expression       = "evaluatePreconfiguredExpr('sqli-v33-stable', {'sensitivity':1, 'opt_out_rule_ids': ['owasp-crs-v030301-id942260-sqli', 'owasp-crs-v030301-id942421-sqli', 'owasp-crs-v030301-id942420-sqli'])"
      source_ip_ranges = "*"
    }
    rule_xss = {
      action     = "deny(403)"
      priority   = "1020"
      preview    = false
      expression = "evaluatePreconfiguredExpr('xss-v33-stable')"
    }
    rule_lfi = {
      action     = "deny(403)"
      priority   = "1030"
      preview    = false
      expression = "evaluatePreconfiguredExpr('lfi-v33-stable')"
    }
    rule_canary = {
      action     = "deny(403)"
      priority   = "1040"
      preview    = false
      expression = "evaluatePreconfiguredExpr('cve-canary')"
    }
    rule_rfi = {
      action     = "deny(403)"
      priority   = "1050"
      preview    = false
      expression = "evaluatePreconfiguredExpr('rfi-v33-stable', {'sensitivity':1, 'opt_out_rule_ids':['owasp-crs-v030301-id931130-rfi']})"
    }
    rule_rce = {
      action     = "deny(403)"
      priority   = "1060"
      preview    = false
      expression = "evaluatePreconfiguredExpr('rce-v33-stable')"
    }
    rule_methodenforcement = {
      action     = "deny(403)"
      priority   = "1070"
      preview    = false
      expression = "evaluatePreconfiguredExpr('methodenforcement-v33-stable')"
    }
    rule_scandetection = {
      action     = "deny(403)"
      priority   = "1080"
      preview    = false
      expression = "evaluatePreconfiguredExpr('scannerdetection-v33-stable')"
    }
    rule_protocolattack = {
      action     = "deny(403)"
      priority   = "1090"
      preview    = false
      expression = "evaluatePreconfiguredExpr('protocolattack-v33-stable', {'sensitivity':1, 'opt_out_rule_ids':['owasp-crs-v030301-id921170-protocolattack']})"
    }
    rule_phpattack = {
      action     = "deny(403)"
      priority   = "1100"
      preview    = true
      expression = "evaluatePreconfiguredExpr('php-v33-stable')"
    }
    rule_sessionfixation = {
      action     = "deny(403)"
      priority   = "1110"
      preview    = true
      expression = "evaluatePreconfiguredExpr('sessionfixation-v33-stable')"
    }
  }
  type = map(object({
    action     = string
    priority   = string
    preview    = bool
    expression = string
  }))
}
