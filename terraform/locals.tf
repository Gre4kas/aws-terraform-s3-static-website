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
    ".js" : "application/javascript",
    ".woff2" : "font/woff2",
    ".png" : "image/png",
    ".min.js" : "application/javascript"
  }
}