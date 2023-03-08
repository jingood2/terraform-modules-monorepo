// s3_lifecycle_test.go

package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	//"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestS3LifecycleModule(t *testing.T) {
	t.Parallel()

	// Generate a random S3 bucket name to ensure uniqueness
	bucketName := "my-bucket-jingood1234"

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/sample",
		Vars: map[string]interface{}{
			"bucket_name":   bucketName,
			"bucket_prefix": "logs/",
			"days":          30,
		},

		// Variables to pass to our Terraform code using -var-file options
		// VarFiles: []string{"varfile.tfvars"},
	}

	// Destroy the infrastructure at the end of the test
	defer terraform.Destroy(t, terraformOptions)

	// Create the infrastructure
	terraform.InitAndApply(t, terraformOptions)

	// Get the AWS region and account ID to find the S3 bucket
	//awsRegion := aws.GetRandomStableRegion(t, nil, nil)
	awsRegion := "ap-northeast-2"
	//awsAccountId := aws.GetAccountId(t)

	// Get the S3 bucket name from the Terraform output
	s3BucketName := terraform.Output(t, terraformOptions, "s3_bucket_name")

	// Ensure that the S3 bucket exists
	aws.AssertS3BucketExists(t, awsRegion, s3BucketName)

	assert.Equal(t, bucketName, s3BucketName)

}
