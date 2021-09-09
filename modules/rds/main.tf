resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.app_name}-${var.environment}-db-subnet"
  }
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  # availability_zones      = ["us-west-2a", "us-west-2b", "us-west-2c"]
  db_subnet_group_name    = aws_db_subnet_group.default.name
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"

  tags = {
    Name = "${var.app_name}-${var.environment}-db-cluster"
  }
}