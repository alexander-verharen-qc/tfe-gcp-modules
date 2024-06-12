# Cloud Armor Security Policy Module

This module is for implementing and creating a project wide Cloud Armor policy, according to standards maintained by THD, HDQC Architecture.

Below is an example of how to implement the module. 

```terraform
module "cloudarmor-public-ingress-owasp" {
  # update the source relative to your module declaration
  # define the variable project_id or set the value appropriately
  source = "../modules/security/owasp" 
  project = var.project_id
  policy_name = "cloudarmor-public-ingress-owasp"
}
```

The module will be created after terraform init, and using terraform plan/apply -target "module.cloudarmor-public-ingress-owasp" you can validate or apply the policy (changes).

The example will create a module named "module.cloudarmor-public-ingress-owasp.google_compute_security_policy.security_policy"

It can be referrenced as;
```terraform
resource "google_compute_backend_service" "your_backend_service" {
  ...
  security_policy                 = var.security_policy_self_link
  timeout_sec                     = 300
  security_policy = module.cloudarmor-public-ingress-owasp.google_compute_security_policy.security_policy.policy_name

  backend {
    ..
    group           = google_compute_instance_group.your_instance_group.self_link
  }
} 
```

The rules for the group are maintained in variables.tf. This policy template will implement:
- "owasp_rules"

```terraform
variable "owasp_rules"
  description = "Ruleset for OWASP-10 Web Application Filtering, easily maintained in this variable set"
  default = {
    rule_sqli = {
      action = "deny(403)"
      priority = "1010"
      preview = true
      expression = "evaluatePreconfiguredExpr('sqli-v33-stable', {'sensitivity': 4, 'opt_out_rule_ids': ['owasp-crs-v030301-id942260-sqli', 'owasp-crs-v030301-id942421-sqli', 'owasp-crs-v030301-id942420-sqli']})"
      source_ip_ranges = "*"
    }
  ...
  }
  type = map(object({
      action     = string
      priority   = string
      preview = bool
      expression = string
    }))
}
```terraform
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.33.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_security_policy.security_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_security_policy) | resource |
| [google cloud armor sensitivity levels & rules](https://cloud.google.com/armor/docs/waf-rules) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_owasp_rules"></a> [owasp\_rules](#input\_owasp\_rules) | Ruleset for OWASP-10 Web Application Filtering, easily maintained in this variable set | <pre>map(object({<br>      action     = string<br>      priority   = string<br>      preview = bool<br>      expression = string<br>    }))</pre> | <pre>{<br>  "rule_canary": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('cve-canary')",<br>    "preview": false,<br>    "priority": "1040"<br>  },<br>  "rule_lfi": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('lfi-v33-stable')",<br>    "preview": true,<br>    "priority": "1030"<br>  },<br>  "rule_methodenforcement": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('methodenforcement-v33-stable')",<br>    "preview": true,<br>    "priority": "1070"<br>  },<br>  "rule_phpattack": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('php-v33-stable')",<br>    "preview": true,<br>    "priority": "1100"<br>  },<br>  "rule_protocolattack": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('protocolattack-v33-stable')",<br>    "preview": true,<br>    "priority": "1090"<br>  },<br>  "rule_rce": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('rce-v33-stable')",<br>    "preview": true,<br>    "priority": "1060"<br>  },<br>  "rule_rfi": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('rfi-v33-stable')",<br>    "preview": true,<br>    "priority": "1050"<br>  },<br>  "rule_scandetection": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('scannerdetection-v33-stable')",<br>    "preview": true,<br>    "priority": "1080"<br>  },<br>  "rule_sessionfixation": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('sessionfixation-v33-stable')",<br>    "preview": true,<br>    "priority": "1110"<br>  },<br>  "rule_sqli": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('sqli-v33-stable')",<br>    "preview": true,<br>    "priority": "1010",<br>    "source_ip_ranges": "*"<br>  },<br>  "rule_xss": {<br>    "action": "deny(403)",<br>    "expression": "evaluatePreconfiguredExpr('xss-v33-stable')",<br>    "preview": true,<br>    "priority": "1020"<br>  }<br>}</pre> | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | The name of the policy. this field is required. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | The name of the policy |
| <a name="output_policy_self_link"></a> [policy\_self\_link](#output\_policy\_self\_link) | The link to the policy |
<!-- END_TF_DOCS -->
