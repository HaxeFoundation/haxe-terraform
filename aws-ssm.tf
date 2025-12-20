data "aws_ssm_parameter" "gandi_personal_access_token" {
  name = "gandi_personal_access_token"
}

# haxe-terraform API token summary
# Haxe - Workers R2 SQL:Read, Workers R2 Data Catalog:Edit, Workers R2 Storage:Edit
# haxe.org - Zone Settings:Edit, DNS:Edit
data "aws_ssm_parameter" "cloudflare_api_token" {
  name = "cloudflare_api_token"
}
data "aws_ssm_parameter" "haxe-terraform-github-app-pem" {
  name = "haxe-terraform-github-app-pem"
}
data "aws_ssm_parameter" "do-k8s-imagepullsecrets" {
  name = "do-k8s-imagepullsecrets"
}
