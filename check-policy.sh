#!/bin/bash

echo "🔄 Running Terraform Plan..."

terraform plan -out=tfplan

if [ $? -ne 0 ]; then
  echo "❌ Terraform plan failed"
  exit 1
fi

echo "🔄 Converting plan to JSON..."

terraform show -json tfplan > tfplan.json

echo "🔍 Running Policy Checks..."

conftest test tfplan.json --policy policy/

if [ $? -ne 0 ]; then
  echo "❌ Policy violations found. Aborting pipeline."
  exit 1
fi

echo "✅ All policies passed. Safe to deploy."
