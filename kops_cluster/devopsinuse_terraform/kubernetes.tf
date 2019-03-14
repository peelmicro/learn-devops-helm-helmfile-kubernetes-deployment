locals = {
  cluster_name                 = "kops.peelmicro.com"
  master_autoscaling_group_ids = ["${aws_autoscaling_group.master-eu-central-1a-masters-kops-peelmicro-com.id}"]
  master_security_group_ids    = ["${aws_security_group.masters-kops-peelmicro-com.id}"]
  masters_role_arn             = "${aws_iam_role.masters-kops-peelmicro-com.arn}"
  masters_role_name            = "${aws_iam_role.masters-kops-peelmicro-com.name}"
  node_autoscaling_group_ids   = ["${aws_autoscaling_group.nodes-kops-peelmicro-com.id}"]
  node_security_group_ids      = ["${aws_security_group.nodes-kops-peelmicro-com.id}"]
  node_subnet_ids              = ["${aws_subnet.eu-central-1a-kops-peelmicro-com.id}"]
  nodes_role_arn               = "${aws_iam_role.nodes-kops-peelmicro-com.arn}"
  nodes_role_name              = "${aws_iam_role.nodes-kops-peelmicro-com.name}"
  region                       = "eu-central-1"
  route_table_public_id        = "${aws_route_table.kops-peelmicro-com.id}"
  subnet_eu-central-1a_id      = "${aws_subnet.eu-central-1a-kops-peelmicro-com.id}"
  vpc_cidr_block               = "${aws_vpc.kops-peelmicro-com.cidr_block}"
  vpc_id                       = "${aws_vpc.kops-peelmicro-com.id}"
}

output "cluster_name" {
  value = "kops.peelmicro.com"
}

output "master_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.master-eu-central-1a-masters-kops-peelmicro-com.id}"]
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-kops-peelmicro-com.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-kops-peelmicro-com.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-kops-peelmicro-com.name}"
}

output "node_autoscaling_group_ids" {
  value = ["${aws_autoscaling_group.nodes-kops-peelmicro-com.id}"]
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-kops-peelmicro-com.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.eu-central-1a-kops-peelmicro-com.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-kops-peelmicro-com.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-kops-peelmicro-com.name}"
}

output "region" {
  value = "eu-central-1"
}

output "route_table_public_id" {
  value = "${aws_route_table.kops-peelmicro-com.id}"
}

output "subnet_eu-central-1a_id" {
  value = "${aws_subnet.eu-central-1a-kops-peelmicro-com.id}"
}

output "vpc_cidr_block" {
  value = "${aws_vpc.kops-peelmicro-com.cidr_block}"
}

output "vpc_id" {
  value = "${aws_vpc.kops-peelmicro-com.id}"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_autoscaling_group" "master-eu-central-1a-masters-kops-peelmicro-com" {
  name                 = "master-eu-central-1a.masters.kops.peelmicro.com"
  launch_configuration = "${aws_launch_configuration.master-eu-central-1a-masters-kops-peelmicro-com.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.eu-central-1a-kops-peelmicro-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kops.peelmicro.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-eu-central-1a.masters.kops.peelmicro.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-eu-central-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-kops-peelmicro-com" {
  name                 = "nodes.kops.peelmicro.com"
  launch_configuration = "${aws_launch_configuration.nodes-kops-peelmicro-com.id}"
  max_size             = 2
  min_size             = 2
  vpc_zone_identifier  = ["${aws_subnet.eu-central-1a-kops-peelmicro-com.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "kops.peelmicro.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.kops.peelmicro.com"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-kops-peelmicro-com" {
  availability_zone = "eu-central-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "a.etcd-events.kops.peelmicro.com"
    "k8s.io/etcd/events"                       = "a/a"
    "k8s.io/role/master"                       = "1"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-kops-peelmicro-com" {
  availability_zone = "eu-central-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "a.etcd-main.kops.peelmicro.com"
    "k8s.io/etcd/main"                         = "a/a"
    "k8s.io/role/master"                       = "1"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
  }
}

resource "aws_iam_instance_profile" "masters-kops-peelmicro-com" {
  name = "masters.kops.peelmicro.com"
  role = "${aws_iam_role.masters-kops-peelmicro-com.name}"
}

resource "aws_iam_instance_profile" "nodes-kops-peelmicro-com" {
  name = "nodes.kops.peelmicro.com"
  role = "${aws_iam_role.nodes-kops-peelmicro-com.name}"
}

resource "aws_iam_role" "masters-kops-peelmicro-com" {
  name               = "masters.kops.peelmicro.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.kops.peelmicro.com_policy")}"
}

resource "aws_iam_role" "nodes-kops-peelmicro-com" {
  name               = "nodes.kops.peelmicro.com"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.kops.peelmicro.com_policy")}"
}

resource "aws_iam_role_policy" "masters-kops-peelmicro-com" {
  name   = "masters.kops.peelmicro.com"
  role   = "${aws_iam_role.masters-kops-peelmicro-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.kops.peelmicro.com_policy")}"
}

resource "aws_iam_role_policy" "nodes-kops-peelmicro-com" {
  name   = "nodes.kops.peelmicro.com"
  role   = "${aws_iam_role.nodes-kops-peelmicro-com.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.kops.peelmicro.com_policy")}"
}

resource "aws_internet_gateway" "kops-peelmicro-com" {
  vpc_id = "${aws_vpc.kops-peelmicro-com.id}"

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "kops.peelmicro.com"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
  }
}

resource "aws_key_pair" "kubernetes-kops-peelmicro-com-14f4e587b84d4819f287bedfda85ac26" {
  key_name   = "kubernetes.kops.peelmicro.com-14:f4:e5:87:b8:4d:48:19:f2:87:be:df:da:85:ac:26"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.kops.peelmicro.com-14f4e587b84d4819f287bedfda85ac26_public_key")}"
}

resource "aws_launch_configuration" "master-eu-central-1a-masters-kops-peelmicro-com" {
  name_prefix                 = "master-eu-central-1a.masters.kops.peelmicro.com-"
  image_id                    = "ami-0692cb5ffed92e0c7"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kops-peelmicro-com-14f4e587b84d4819f287bedfda85ac26.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-kops-peelmicro-com.id}"
  security_groups             = ["${aws_security_group.masters-kops-peelmicro-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-eu-central-1a.masters.kops.peelmicro.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-kops-peelmicro-com" {
  name_prefix                 = "nodes.kops.peelmicro.com-"
  image_id                    = "ami-0692cb5ffed92e0c7"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-kops-peelmicro-com-14f4e587b84d4819f287bedfda85ac26.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-kops-peelmicro-com.id}"
  security_groups             = ["${aws_security_group.nodes-kops-peelmicro-com.id}"]
  associate_public_ip_address = true
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.kops.peelmicro.com_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.kops-peelmicro-com.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.kops-peelmicro-com.id}"
}

resource "aws_route_table" "kops-peelmicro-com" {
  vpc_id = "${aws_vpc.kops-peelmicro-com.id}"

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "kops.peelmicro.com"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
    "kubernetes.io/kops/role"                  = "public"
  }
}

resource "aws_route_table_association" "eu-central-1a-kops-peelmicro-com" {
  subnet_id      = "${aws_subnet.eu-central-1a-kops-peelmicro-com.id}"
  route_table_id = "${aws_route_table.kops-peelmicro-com.id}"
}

resource "aws_security_group" "masters-kops-peelmicro-com" {
  name        = "masters.kops.peelmicro.com"
  vpc_id      = "${aws_vpc.kops-peelmicro-com.id}"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "masters.kops.peelmicro.com"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
  }
}

resource "aws_security_group" "nodes-kops-peelmicro-com" {
  name        = "nodes.kops.peelmicro.com"
  vpc_id      = "${aws_vpc.kops-peelmicro-com.id}"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "nodes.kops.peelmicro.com"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-peelmicro-com.id}"
  source_security_group_id = "${aws_security_group.masters-kops-peelmicro-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  source_security_group_id = "${aws_security_group.masters-kops-peelmicro-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "https-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kops-peelmicro-com.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-kops-peelmicro-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-peelmicro-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-peelmicro-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-peelmicro-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-kops-peelmicro-com.id}"
  source_security_group_id = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-kops-peelmicro-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-kops-peelmicro-com.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "eu-central-1a-kops-peelmicro-com" {
  vpc_id            = "${aws_vpc.kops-peelmicro-com.id}"
  cidr_block        = "172.20.32.0/19"
  availability_zone = "eu-central-1a"

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "eu-central-1a.kops.peelmicro.com"
    SubnetType                                 = "Public"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
    "kubernetes.io/role/elb"                   = "1"
  }
}

resource "aws_vpc" "kops-peelmicro-com" {
  cidr_block           = "172.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "kops.peelmicro.com"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options" "kops-peelmicro-com" {
  domain_name         = "eu-central-1.compute.internal"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    KubernetesCluster                          = "kops.peelmicro.com"
    Name                                       = "kops.peelmicro.com"
    "kubernetes.io/cluster/kops.peelmicro.com" = "owned"
  }
}

resource "aws_vpc_dhcp_options_association" "kops-peelmicro-com" {
  vpc_id          = "${aws_vpc.kops-peelmicro-com.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.kops-peelmicro-com.id}"
}

terraform = {
  required_version = ">= 0.9.3"
}
