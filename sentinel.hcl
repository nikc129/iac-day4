import "tfplan"

# Rule: All S3 buckets must have "Environment" tag
main = rule {
  all tfplan.resources.aws_s3_bucket as _, bucket {
    bucket.applied.tags["Environment"] is not null
  }
}
