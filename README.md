# VPC
In this project I am creating a basic block of my main-project of VPC Peering using Terraform
In this project I have built a VPC,subnet,EC2 instance,IGW, routes and associtaed routes for EC2
To enable access to or from the internet for instances in a subnet in a VPC, you must do the following:
Attach an internet gateway to your VPC.
Add a route to your subnet's route table that directs internet-bound traffic to the internet gateway. If a subnet is associated with a route table that has a route to an internet gateway, it's known as a public subnet. If a subnet is associated with a route table that does not have a route to an internet gateway, it's known as a private subnet.
Ensure that instances in your subnet have a globally unique IP address (public IPv4 address, Elastic IP address, or IPv6 address).
Ensure that your network access control lists and security group rules allow the relevant traffic to flow to and from your instance. https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html
Note: EC2 is created without KeyPair, so it can't be accessed through ssh
