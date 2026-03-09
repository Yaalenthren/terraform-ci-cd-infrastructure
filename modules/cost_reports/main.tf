resource "aws_s3_bucket" "cur_bucket" {
  bucket = "dev-terraform-usage-report"  # must be globally unique
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_cur_report_definition" "monthly_cost_report" {
  report_name          = "dev-monthly-cost-report"
  time_unit            = "DAILY"
  format               = "textORcsv"
  compression          = "GZIP"
  s3_bucket            = aws_s3_bucket.cur_bucket.bucket
  s3_region            = "us-east-1"
  additional_schema_elements = ["RESOURCES"]
  refresh_closed_reports      = true
  report_versioning            = "CREATE_NEW_REPORT"
}