package main

# ❌ Deny public S3 bucket
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"

  # check ACL
  resource.change.after.acl == "public-read"

  msg = sprintf("Bucket %v cannot be public", [resource.name])
}

# ❌ Deny missing encryption
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"

  not resource.change.after.server_side_encryption_configuration

  msg = sprintf("Bucket %v must have encryption enabled", [resource.name])
}
