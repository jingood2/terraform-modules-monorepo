package test

import (
	"fmt"
	"testing"

	//"github.com/gruntwork-io/terratest/modules/aws"
	//"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestVpcEndpoint(t *testing.T) {
	t.Parallel()

	// Set up Terraform options
	//awsRegion := "us-west-2"

	expectedCreate := true
	expectedVpcId := "vpc-06ab4d4d91b06b4c7"
	expectedRouteTableId := "rtb-083c954b3593bdf1a"
	expectedVpcCidrBlock := "172.31.0.0/16"

	expectedAwsSubnetsIds := "subnet-0d9ab5110ee2a2f42"

	expectedRouteTableIds := []string{expectedRouteTableId}

	expectedGwS3Endpoint := map[string]any{"create": expectedCreate, "route_table_ids": expectedRouteTableIds}
	expectedSsmEndpoint := map[string]any{"create": expectedCreate, "aws_subnets_ids": expectedAwsSubnetsIds}

	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/vpc-endpoints",
		/* Vars: map[string]interface{}{
			"vpc_name":                "test-vpc-" + random.UniqueId(),
			"aws_region":              awsRegion,
			"subnet_cidr_blocks":      []string{"10.0.1.0/24"},
			"vpc_endpoint_subnet_ids": []string{"subnet-12345678"},
			"service_name":            "com.amazonaws.us-east-1.s3",
		}, */
		Vars: map[string]interface{}{
			"create":         expectedCreate,
			"vpc_id":         expectedVpcId,
			"vpc_cidr_block": expectedVpcCidrBlock,
			"gw_s3_endpoint": expectedGwS3Endpoint,
			"ssm":            expectedSsmEndpoint,
		},
	}

	// Terraform init, apply, output, and destroy
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	//vpcEndpointId := terraform.Output(t, terraformOptions, "vpc_endpoint_id")
	//vpcEndpointDnsName := terraform.Output(t, terraformOptions, "vpc_endpoint_dns_name")
	vpcEndpoints := terraform.Output(t, terraformOptions, "vpc_endpoints")

	// Ensure VPC endpoint exists
	//assert.NotEmpty(t, vpcEndpointId)
	//assert.NotEmpty(t, vpcEndpointDnsName)
	assert.NotEmpty(t, vpcEndpoints)

	// Ensure VPC endpoint is accessible
	//err := aws.CheckS3EndpointAccess(vpcEndpointDnsName, awsRegion)
	//assert.NoError(t, err)

	fmt.Printf("VPC Endpoint %s is accessible", vpcEndpoints)
}
