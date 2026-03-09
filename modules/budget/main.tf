resource "aws_budgets_budget" "monthly_budget" {
  name              = "dev-aws-budget"
  budget_type       = "COST"
  limit_amount      = "5"       # $5 monthly budget (adjust as needed)
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  cost_filters      = {}        # empty = all services
  cost_types {
    include_tax      = true
    include_subscription = true
    include_support  = true
    include_recurring = true
    include_other    = true
  }

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 80       # 80% of the budget
    threshold_type      = "PERCENTAGE"
    subscriber {
      subscription_type = "EMAIL"
      address           = "yalenthren2003@example.com"  
    }
  }

  notification {
    comparison_operator = "GREATER_THAN"
    notification_type   = "ACTUAL"
    threshold           = 100      # 100% of the budget
    threshold_type      = "PERCENTAGE"
    subscriber {
      subscription_type = "EMAIL"
      address           = "yalenthren2003@example.com"
    }
  }
}