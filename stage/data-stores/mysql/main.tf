# ╔══════════════════╤═══════════════════════════════════╗
# ║  █████╗ ██████╗  │ Terraform (ver: 0.12)             ║
# ║ ██╔══██╗██╔══██╗ │                                   ║
# ║ ███████║██████╔╝ │ Amazon RDS definition             ║
# ║ ██╔══██║██╔═══╝  │                                   ║
# ║ ██║  ██║██║      │ Author(s): Alain Palenzuela       ║
# ║ ╚═╝  ╚═╝╚═╝      │ E-mail: alainpalenzuela@gmail.com ║
# ╚══════════════════╧═══════════════════════════════════╝

# -------------------------------------
# Define Provider
# -------------------------------------
provider "aws" {														# Provider AWS
	region = "us-east-1"											# Region defintion based on VPC
}

# -------------------------------------
# Define where to save Terraform state
# -------------------------------------
terraform {
	backend "s3" {
		bucket	= "apalen-east1-bucket-terraform"
		region	= "us-east-1"
		key			= "stage/data-stores/mysql/terraform.tfstate"
		encrypt = true
	}
}

# -------------------------------------
# Define DB 
# -------------------------------------
resource "aws_db_instance" "example" {			# AWS DB defintion and Resource name
	engine						= "mysql"								# Engine type
	engine_version		= "5.7"									# Engine version 5.7 as MySQL
	allocated_storage = 10										# 10 GB of space
	instance_class		= "db.t2.micro"					# Type of the DB instance: 1 CPU, 1GB RAM
	name							= "example_database"		# Database name
	username					= "admin"								# User (root)
	password					= var.db_password				# Root passwd
}

// -------------------------------------
// END
// -------------------------------------
