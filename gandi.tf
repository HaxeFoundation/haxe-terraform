resource "gandi_nameservers" "haxe_org" {
  domain = "haxe.org"
  nameservers = [
    "ns-124.awsdns-15.com",
    "ns-1051.awsdns-03.org",
    "ns-1800.awsdns-33.co.uk",
    "ns-702.awsdns-23.net",

    # Cloudflare nameservers
    # commented out unit we created all dns records in Cloudflare
    # "beau.ns.cloudflare.com",
    # "zariyah.ns.cloudflare.com",
  ]
}
