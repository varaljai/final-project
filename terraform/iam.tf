resource "aws_iam_policy" "s3_backup_policy" {
  name        = "SerpentS3BackupPolicy"
  description = "Allow EC2 to upload backups to S3"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
  "s3:DeleteObject"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.backups.bucket}/*",
          "arn:aws:s3:::${aws_s3_bucket.backups.bucket}"
        ]
      }
    ]
  })
}

# 2. IAM role that EC2 can assume
resource "aws_iam_role" "ec2_backup_role" {
  name = "SerpentEC2S3Role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# 3. Attach the policy to the role
resource "aws_iam_role_policy_attachment" "ec2_backup_attachment" {
  role       = aws_iam_role.ec2_backup_role.name
  policy_arn = aws_iam_policy.s3_backup_policy.arn
}

# 4. Create an instance profile to attach the IAM role to EC2
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "SerpentEC2InstanceProfile"
  role = aws_iam_role.ec2_backup_role.name
}
