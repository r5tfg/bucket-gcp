# Bucket to store website

resource "google_storage_bucket" "website" { # The names here are a reference for Terraform not for GCP.
  name = "website-turulu" # This is the bucket name that GCP will know.
  location = "US"
}

# Make new object public
resource "google_storage_object_access_control" "public_rule" { 
  object = google_storage_bucket_object.static_site_src.name
  bucket = google_storage_bucket.website.name
  role = "READER"
  entity = "allUsers"
}



# Upload index.html to bucket

resource "google_storage_bucket_object" "static_site_src" {
  name = "index.html"
  source = "website/index.html"
  bucket = google_storage_bucket.website.name #this is readed "bucket = resource type.reference name.name of the bucket"
}

# Reserve a  static external IP address

resource "google_compute_global_address" "website_ip" {
  name = "website-lb-ip" #This will give us an IP that will be reserved for us for our load balancer later on.
}