output "public_ip" {
  value = aws_eip.wordpress_eip.public_ip
}

output "wordpress_url" {
  value = "http://${aws_eip.wordpress_eip.public_ip}"
}
