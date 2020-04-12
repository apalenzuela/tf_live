# ╔══════════════════╤═══════════════════════════════════╗
# ║  █████╗ ██████╗  │ Terraform (ver: 0.12)             ║
# ║ ██╔══██╗██╔══██╗ │                                   ║
# ║ ███████║██████╔╝ │ Create ELB, ASG with EC2          ║
# ║ ██╔══██║██╔═══╝  │                                   ║
# ║ ██║  ██║██║      │ Author(s): Alain Palenzuela       ║
# ║ ╚═╝  ╚═╝╚═╝      │ E-mail: alainpalenzuela@gmail.com ║
# ╚══════════════════╧═══════════════════════════════════╝

# -------------------------------------
# Define Provider
# -------------------------------------
provider "aws" {
	region = "us-east-1"
}

# --------------------------------------
# Define Admin of resources by time
# --------------------------------------
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
	scheduled_action_name		= "scale-out-during-business-hours"
	min_size					= 2
	max_size					= 10
	desired_capacity			= 10 
	recurrence					= "0 9 * * *"

	autoscaling_group_name		= module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
	scheduled_action_name		= "scale-in-at-night"
	min_size					= 2
	max_size					= 10
	desired_capacity			= 2
	recurrence					= "0 17 * * *"

	autoscaling_group_name		= modules.services.webserver_cluster.asg_name
}

# --------------------------------------
# Define WebCluster parameter
# --------------------------------------
module "webserver_cluster" {
	source = "/home/alain/terraform/modules/services/webserver-cluster"
 
	elb_env						= "prod"

	cluster_name				= "webservers-prod"
	db_remote_state_bucket		= "apalen-east1-bucket-terraform"
	db_remote_state_key			= "live/prod/data-stores/mysql/terraform.tfstate"

	instance_type				= "m4.large"
	min_size					= 2
	max_size					= 10
}

# --------------------------------------
# END
# --------------------------------------
