resource "aws_s3_bucket" "b" {
  bucket = "my-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}

resource "aws_s3_bucket_website_configuration" "example" {
  bucket = aws_s3_bucket.my-bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}

data "aws_s3_bucket_policy" "example" {
  bucket = "my-bucket"
}

output "foo" {
  value = data.aws_s3_bucket_policy.example.policy
}

data "aws_s3_object" "bootstrap_script" {
  bucket = "ourcorp-deploy-config"
  key    = "ec2-bootstrap-script.sh"
}
