resource "aws_s3_bucket" "contact_form_db" {
  bucket = local.contact_form_db_name
  acl    = "private"

  tags = {
    Name        = local.contact_form_db_name
    Description = "A bucket to cheaply store Contact forms"
  }
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

resource "aws_s3_bucket_public_access_block" "contact_form_db_bpa" {
    bucket = aws_s3_bucket.contact_form_db.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true  
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid = "1"

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${local.contact_form_db_name}/*",
    ]

    principals {
      type = "AWS"

      identifiers = [
        aws_iam_role.iam_for_lambda.arn,
      ]
    }
  }
}