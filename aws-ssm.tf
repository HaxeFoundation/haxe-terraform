data "aws_ssm_parameter" "gandi_api_key" {
  name = "gandi_api_key"
}
data "aws_ssm_parameter" "cloudflare_api_token" {
  name = "cloudflare_api_token"
}
