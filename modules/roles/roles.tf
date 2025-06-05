data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_ecr_role" {
    name = "ec2-ecr-role"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
  
}

resource "aws_iam_role_policy_attachment" "ec2_assume_role" {

role = aws_iam_role.ec2_ecr_role.name   
policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"

}

resource "aws_iam_instance_profile" "ec2_ecr_profile" {
    name = "ec2-profile"
    role = aws_iam_role.ec2_ecr_role.name
}