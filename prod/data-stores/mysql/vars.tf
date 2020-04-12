# ╔══════════════════╤═══════════════════════════════════╗
# ║  █████╗ ██████╗  │ Terraform (ver: 0.12)             ║
# ║ ██╔══██╗██╔══██╗ │                                   ║
# ║ ███████║██████╔╝ │ Amazon RDS definition             ║
# ║ ██╔══██║██╔═══╝  │                                   ║
# ║ ██║  ██║██║      │ Author(s): Alain Palenzuela       ║
# ║ ╚═╝  ╚═╝╚═╝      │ E-mail: alainpalenzuela@gmail.com ║
# ╚══════════════════╧═══════════════════════════════════╝

/*
 NOTE: this variable does not have a 'default' this is
       intentional. You should not store your datbase
       password or any sensitive information in plain
       text. Instead your should store all secrets using
       a password manager that will encrypt your
       sensitive data, and expose those secrets to
       terraform
ex:
  $> export TF_VAR_db_password="(YOUR_DB_PASSWORD)"

*/

variable "db_password" {
  description = "The password for the database"
}

# -------------------------------------
# END
# -------------------------------------
