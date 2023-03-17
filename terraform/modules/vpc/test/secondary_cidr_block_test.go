package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// This function is a test function for the VPC module
func TestSecondaryCidrBlock(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/secondary-cidr-block",
		VarFiles:     []string{"varfile.auto.tfvars"},
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	vpcCidrBlock := terraform.Output(t, terraformOptions, "vpc_cidr_block")
	vpcId := terraform.Output(t, terraformOptions, "vpc_id")

	subnets := aws.GetSubnetsForVpc(t, vpcId, "us-east-1")

	require.Equal(t, 8, len(subnets))

	assert.Equal(t, vpcCidrBlock, "10.0.0.0/16")
}
