resource "aws_s3_bucket" "lambda_zip_bucket" {
  bucket = "${var.bucket_name}-${var.env}"

  tags = var.common_tags
}

resource "aws_s3_bucket_versioning" "lambda_zip_bucket_versioning" {
  bucket = aws_s3_bucket.lambda_zip_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "lambda_cross_account_access" {
  statement {
    sid = "AllowLambdaCodeReadCrossAccount"

    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${var.prod_account_id}:root",
        "arn:aws:iam::${var.dev_account_id}:root",
        "arn:aws:iam::${var.stage_account_id}:root"
      ]

    }

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion"
    ]

    resources = [
      "${aws_s3_bucket.lambda_zip_bucket.arn}/*"
    ]

  }
}

resource "aws_s3_bucket_policy" "bucket_lambda_policy" {
  bucket = aws_s3_bucket.lambda_zip_bucket.id
  policy = data.aws_iam_policy_document.lambda_cross_account_access.json
}
