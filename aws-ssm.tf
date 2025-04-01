data "aws_ssm_parameter" "gandi_personal_access_token" {
  name = "gandi_personal_access_token"
}
data "aws_ssm_parameter" "cloudflare_api_token" {
  name = "cloudflare_api_token"
}
data "aws_ssm_parameter" "haxe-terraform-github-app-pem" {
  name = "haxe-terraform-github-app-pem"
}
