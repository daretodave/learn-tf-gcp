# k8 cluster

A Google Cloud Platform (GCP) Kubernetes cluster module. Instantiates a GKE cluster with a single (or more) node pool.

## Prerequisites

- Required Terraform version
- Dependency modules or resources
- Any provider-specific requirements (AWS, GCP, Azure, etc.)

## Module Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| foo  | Description of the 'foo' input | string | `"bar"` | no |
| bar  | Description of the 'bar' input | list  | [] | yes |

## Module Outputs

| Name | Description |
|------|-------------|
| output1 | Description of what `output1` represents |
| output2 | Description of what `output2` represents |

## Usage 
```hcl module 
"k8-cluster" { 
  source = "../modules/k8-cluster" foo = "value" bar = ["value1", "value2"] 
}
```

## Notes

Any additional notes regarding the nested module.

## Author Information

Information about the author or organization maintaining the module.