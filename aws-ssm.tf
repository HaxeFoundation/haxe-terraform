data "aws_ssm_parameter" "gandi_api_key" {
  name = "gandi_api_key"
}
data "aws_ssm_parameter" "cloudflare_api_token" {
  name = "cloudflare_api_token"
}
data "aws_ssm_parameter" "haxe-terraform-github-app-pem" {
  name = "haxe-terraform-github-app-pem"
}
