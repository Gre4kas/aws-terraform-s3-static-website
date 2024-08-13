locals {
  bucket_name = "static-website-${random_pet.bucket_suffix.id}"
}

resource "random_pet" "bucket_suffix" {
  length = 2
}

locals {
  content_types = {
    ".html" : "text/html",
    ".css" : "text/css",
    ".js" : "text/javascript"
  }
}
