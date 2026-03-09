resource "aws_s3_bucket" "cur_bucket" {
  bucket = "dev-terraform-usage-report"

  tags = {
    Name = "CostUsageReportBucket"
  }
}

resource "aws_s3_bucket_policy" "cur_bucket_policy" {
  bucket = aws_s3_bucket.cur_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AllowBillingGetBucketAcl"
        Effect = "Allow"
        Principal = {
          Service = "billingreports.amazonaws.com"
        }
        Action = [
          "s3:GetBucketAcl",
          "s3:GetBucketPolicy"
        ]
        Resource = aws_s3_bucket.cur_bucket.arn
      },
      {
        Sid = "AllowBillingPutObject"
        Effect = "Allow"
        Principal = {
          Service = "billingreports.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.cur_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_cur_report_definition" "monthly_cost_report" {
  report_name                = "dev-monthly-cost-report"
  time_unit                  = "DAILY"
  format                     = "textORcsv"
  compression                = "GZIP"
  s3_bucket                  = aws_s3_bucket.cur_bucket.bucket
  s3_region                  = "us-east-1"
  s3_prefix                  = "cost-reports"

  additional_schema_elements = ["RESOURCES"]
  refresh_closed_reports     = true
  report_versioning          = "CREATE_NEW_REPORT"
}