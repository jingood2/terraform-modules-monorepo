resource "tls_private_key" "ed25519-example" {
  algorithm = "ED25519"
}

# Public key loaded from a terraform-generated private key, using the PEM (RFC 1421) format
data "tls_public_key" "private_key_pem-example" {
  private_key_pem = tls_private_key.ed25519-example.private_key_pem
}

# Public key loaded from filesystem, using the Open SSH (RFC 4716) format
#data "tls_public_key" "private_key_openssh-example" {
#  private_key_openssh = file("~/.ssh/id_rsa_rfc4716")
#}

resource "aws_key_pair" "example_keypair" {
  key_name   = var.key_name
  public_key = data.tls_public_key.private_key_pem-example.public_key_openssh
}

resource "null_resource" "download_private_key" {
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ed25519-example.private_key_pem}' > ${path.module}/${aws_key_pair.example_keypair.key_name}.pem"
  }
}
