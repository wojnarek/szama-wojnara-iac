resource "aws_ecr_repository" "ecr_app" {
    name  = "app-ecr"
    image_tag_mutability = "MUTABLE"
}

resource "aws_ecr_repository" "ecr_app_backend" {
    name  = "app-ecr-backend"
    image_tag_mutability = "MUTABLE"
}