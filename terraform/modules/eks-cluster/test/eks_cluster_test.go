package test

import (
	"testing"

	//"github.com/aws/aws-sdk-go/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestEksCluster(t *testing.T) {
	// Set the AWS region and load Terraform variables
	/* 	awsRegion := "ap-northeast-2"
	   	environment := "dev"
	   	businessDivsion := "poc"
	   	vpcId := "vpc-0cf5263ae1a0c2e03" */
	clusterName := "poc-dev-eksdemo"
	//eksClusterName := "test-" + random.UniqueId()

	/* terraformVars := map[string]interface{}{
		"aws_region":       awsRegion,
		"environment":      environment,
		"business_divsion": businessDivsion,
		"vpc_id":           vpcId,
	} */

	// Deploy the EKS cluster with Terraform
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/eks-cluster",
		//Vars:         terraformVars,

		VarFiles: []string{"varfile.auto.tfvars"},
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	// Get the EKS cluster name and ARN from the Terraform output
	expectedClusterName := terraform.Output(t, terraformOptions, "cluster_id")
	//clusterArn := terraform.Output(t, terraformOptions, "cluster_arn")

	// Verify that the EKS cluster was created successfully
	//cluster := aws.GetEksCluster(t, clusterName, terraformOptions.Vars["aws_region"].(string))

	assert.Equal(t, expectedClusterName, clusterName)

}
