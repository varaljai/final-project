resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "backups" {
  bucket        = "serpent-surge-backups-${random_id.suffix.hex}"
  force_destroy = true

  tags = {
    Name = "serpent-backups"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "expiration" {
  bucket = aws_s3_bucket.backups.bucket

  rule {
    id     = "limit-backups"
    status = "Enabled"

    filter {
      prefix = ""
    }

    expiration {
      days = 7
    }
  }
}
