

resource "aws_iam_role" "ec2-role" {
  name = "app1-ec2-role"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "cloudtrail:LookupEvents"           
            ],
            "Resource": "*"
        }
    ]
  })
}

resource "aws_iam_instance_profile" "this" {
  name = "ecr-profile"
  role = aws_iam_role.ec2-role.name
}

