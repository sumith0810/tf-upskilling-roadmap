terraform {
  backend "gcs" {
    bucket = "upskilling-platform-dev-tfstate"
    prefix = "terraform/state/dev"
  }
}