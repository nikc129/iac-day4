package policy.s3

# Default deny
default allow = false

# Allow only if S3 bucket is private
allow {
    input.resource_type == "aws_s3_bucket"
    not public_access
}

# Detect if bucket is public
public_access {
    input.acl == "public-read"
}

public_access {
    input.acl == "public-read-write"
}

public_access {
    input.policy.Statement[_].Effect == "Allow"
    input.policy.Statement[_].Principal == "*"
}
