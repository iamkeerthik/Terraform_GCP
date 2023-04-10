# credentials       = "credentials.json"
name              = "terraform-demo"
gcp_project       = "quickstart-1559963030019"
region            = "us-central1"
zone              = "us-central1-a"
private_subnet_cidr_range = "10.0.0.0/24"
public_subnet_cidr_range = "10.0.1.0/24"



####Compute############
instance_type = "e2-small"
instance_zone = "us-central1-a"


#####GKE##############
gke_node_type = "e2-small"
node_count = 1
min_node_count = 1
max_node_count = 2

#######Pub-Sub########
topics = [ "topic-1",  "topic-2",  "topic-3"]
subscriptions = [ "sub-1",  "sub-2",  "sub-3"]

########SQL############
db_tier = "db-f1-micro"