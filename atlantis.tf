module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "~> 3.0"

  name = "atlantis"

  # VPC
  cidr            = "10.20.0.0/16"
  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]

  # DNS (without trailing dot)
  route53_zone_name = "griffith.cloud"

  ecs_fargate_spot = true

  # atlantis_image = ""

  # Atlantis
  atlantis_github_app_id     = "299494"
  atlantis_github_app_key    = data.aws_ssm_parameter.github_key.value
  atlantis_repo_allowlist    = ["github.com/lukegriffith/*"]
}


// Manually bootstrap key from github app.
data "aws_ssm_parameter" "github_key" {
  name = "atlantis-github-key"
}

output "atlantis" {
  value = module.atlantis
  sensitive = true
}


