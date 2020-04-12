# ╔══════════════════╤═══════════════════════════════════╗
# ║  █████╗ ██████╗  │ Terraform (ver: 0.12)             ║
# ║ ██╔══██╗██╔══██╗ │                                   ║
# ║ ███████║██████╔╝ │ Create ELB, ASG with EC2          ║
# ║ ██╔══██║██╔═══╝  │                                   ║
# ║ ██║  ██║██║      │ Author(s): Alain Palenzuela       ║
# ║ ╚═╝  ╚═╝╚═╝      │ E-mail: alainpalenzuela@gmail.com ║
# ╚══════════════════╧═══════════════════════════════════╝

# ---------------------------------------
# Define Provider
# ---------------------------------------
provider "aws" {
	region = "us-east-1"
}

# ---------------------------------------
# Define Admin of resourcess by time
# ---------------------------------------
resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
	scheduled_action_name		= "scale-out-during-business-hours"
	min_size					= 2
	max_size					= 10
	desired_capacity			= 10
	recurrence					= "0 9 * * *"

	autoscaling_group_name	= module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
	scheduled_action_name		= "scale-in-at-night"
	min_size					= 2
	max_size					= 10
	desired_capacity			= 2
	recurrence					= "0 17 * * *"

	autoscaling_group_name	= module.webserver_cluster.asg_name
}

# ---------------------------------------
#
# ---------------------------------------
module "webserver_cluster" {
	source						= "git::git@github.com:apalenzuela/tf_modules.git//services/webserver-cluster?ref=v0.0.1"

	elb_env						= "stage"

	cluster_name				= "webservers-stage"
	db_remote_state_bucket		= "apalen-east1-bucket-terraform"
	db_remote_state_key			= "stage/data-stores/mysql/terraform.tfstate"

	instance_type				= "t2.micro"
	min_size					= 2
	max_size					=	2
}

# -----------------------------------------
# END
# -----------------------------------------
