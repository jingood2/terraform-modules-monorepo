package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestCreateEC2KeyPair(t *testing.T) {
	// Set the AWS region and the Terraform directory
	terraformDir := "../examples/ec2-keypair"

	// Set the name for the key pair
	keyPairName := "example-keypair"

	// Configure the Terraform options with the directory and variables
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: terraformDir,
		Vars: map[string]interface{}{
			"key_name": keyPairName,
		},
	})

	// Ensure the key pair is destroyed after the test finishes
	defer terraform.Destroy(t, terraformOptions)

	// Create the EC2 key pair using Terraform
	terraform.InitAndApply(t, terraformOptions)

	// Get the EKS cluster name and ARN from the Terraform output
	expectedResult := terraform.Output(t, terraformOptions, "keypair")

	assert.NotEqual(t, expectedResult, keyPairName)
}
