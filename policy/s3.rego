package main

# ❌ Deny public bucket
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"
  resource.change.after.acl == "public-read"

  msg = sprintf("Bucket %v cannot be public", [resource.name])
}

# ❌ Deny if encryption resource is missing
deny[msg] {
  bucket := input.resource_changes[_]
  bucket.type == "aws_s3_bucket"

  not encryption_exists(bucket.name)

  msg = sprintf("Bucket %v must have encryption enabled", [bucket.name])
}

# ✅ Helper: check encryption resource exists
encryption_exists(bucket_name) {
  enc := input.resource_changes[_]
  enc.type == "aws_s3_bucket_server_side_encryption_configuration"
}package main

# ❌ Deny public bucket
deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"
  resource.change.after.acl == "public-read"

  msg = sprintf("Bucket %v cannot be public", [resource.name])
}

# ❌ Deny if encryption resource is missing
deny[msg] {
  bucket := input.resource_changes[_]
  bucket.type == "aws_s3_bucket"

  not encryption_exists(bucket.name)

  msg = sprintf("Bucket %v must have encryption enabled", [bucket.name])
}

# ✅ Helper: check encryption resource exists
encryption_exists(bucket_name) {
  enc := input.resource_changes[_]
  enc.type == "aws_s3_bucket_server_side_encryption_configuration"
}
