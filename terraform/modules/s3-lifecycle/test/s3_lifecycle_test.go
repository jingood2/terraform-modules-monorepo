// s3_lifecycle_test.go

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestS3LifecycleModule(t *testing.T) {
	t.Parallel()

	// Generate a random S3 bucket name to ensure uniqueness
	bucketName := "my-bucket-" + random.UniqueId()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/s3-lifecycle",
		Vars: map[string]interface{}{
			"bucket_name": bucketName,
			"prefix":      "logs/",
			"days":        30,
		},

		// Variables to pass to our Terraform code using -var-file options
		// VarFiles: []string{"varfile.tfvars"},
	}

	// Destroy the infrastructure at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Create the infrastructure
	terraform.InitAndApply(t, terraformOptions)

	// Get the AWS region and account ID to find the S3 bucket
	awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	awsAccountId := aws.GetAccountId(t)

	// Get the S3 bucket name from the Terraform output
	s3BucketName := terraform.Output(t, terraformOptions, "s3_bucket_name")

	// Ensure that the S3 bucket exists
	aws.AssertS3BucketExists(t, awsRegion, s3BucketName)

	// Ensure that the S3 bucket has a lifecycle policy with the expected configuration
	expectedLifecyclePolicy := `
		{
			"Rules": [
				{
					"Prefix": "logs/",
					"Status": "Enabled",
					"Transitions": [
						{
							"Days": 30,
							"StorageClass": "GLACIER"
						}
					]
				}
			]
		}
	`

	actualLifecyclePolicy := aws.GetS3BucketPolicy(t, awsRegion, s3BucketName)

	assert.JSONEq(t, expectedLifecyclePolicy, actualLifecyclePolicy)
}