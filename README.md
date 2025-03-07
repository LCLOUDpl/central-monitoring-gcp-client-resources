# Central Monitoring GCP Client Resources

Basic Terraform to configure resources needed for integration with Central Monitoring, which can also be used as a module.


## Usage

```hcl
module "lcloud_monitoring" {
  source = "git::https://github.com/LCLOUDpl/central-monitoring-gcp-client-resources.git?ref=v1.0"

  endpoint    = "https://central-monitoring-api.srv.lcloud.pl/v1/gcp-monitoring/*****"
  environment = "staging"
}
```


## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| google | >= 6.12.0 |


## Providers

| Name | Version |
|------|---------|
| google | >= 6.12.0 |


## Modules

No modules.


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| endpoint | Central Monitoring endpoint for receiving events from Google Cloud Platform. | `string` | `""` | yes |
| environment | Environment name. | `string` | null | yes |


## Outputs

| Name | Description |
|------|-------------|
| monitoring_topic_id | ID of the monitoring Pub/Sub topic |
| monitoring_topic_name | Name of the monitoring Pub/Sub topic |
| monitoring_subscription_id | ID of the monitoring subscription system |
| monitoring_subscription_name | Name of the monitoring subscription system |
