# ╔══════════════════╤═══════════════════════════════════╗
# ║  █████╗ ██████╗  │ Terraform (ver: 0.12)             ║
# ║ ██╔══██╗██╔══██╗ │                                   ║
# ║ ███████║██████╔╝ │ Create ELB, ASG with EC2          ║
# ║ ██╔══██║██╔═══╝  │                                   ║
# ║ ██║  ██║██║      │ Author(s): Alain Palenzuela       ║
# ║ ╚═╝  ╚═╝╚═╝      │ E-mail: alainpalenzuela@gmail.com ║
# ╚══════════════════╧═══════════════════════════════════╝
## vim tabstop=8 expandtab shiftwidth=4 softtabstop=4

# ------------------------------------
# Define Output value
# ------------------------------------
output "elb_dns_name" {
  value = "${module.webserver_cluster.elb_dns_name}"
}

# ------------------------------------
# END
# ------------------------------------
