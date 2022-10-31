#  Project variables
environment        = "dev"
region     = "us-east-1" # Region has to be us-east-1 for WAF

account_id = 351484734788

# Route 53
domain_name = "demo"
dns_zone = "risc0demonstration.io"

log_retention = 90

default_origin = "risczerodemonstration"
origins = {"risczerodemonstration" = {path = "/risczerodemonstration", bucket = "public-risczerodemonstration" }}

whitelist_ips = ["75.166.43.168/32", "3.121.56.176/32"]
application = "demo"
