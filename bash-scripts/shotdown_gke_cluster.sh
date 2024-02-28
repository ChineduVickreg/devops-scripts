# #!/bin/bash
# gcloud container clusters get-credentials dev-upgraded --zone europe-west3-a --project spleet-cms-1568627972284
# gcloud container clusters resize dev-upgraded --node-pool upgraded-dev-nodes --num-nodes 0 --zone europe-west3-a -q
#

#!/bin/bash

# Set your GCP project and cluster details
PROJECT_ID=spleet-cms-1568627972284
CLUSTER_NAME=dev-upgraded
ZONE=europe-west3-a
NODE_POOL_NAME=dev-upgraded-nodepool

# Function to scale down the node pool
scale_down() {
  echo "Scaling down the node pool..."
  gcloud container clusters resize $CLUSTER_NAME --node-pool=$NODE_POOL_NAME --num-nodes=0 --zone=$ZONE --project=$PROJECT_ID
}

# Function to scale up the node pool
scale_up() {
  echo "Scaling up the node pool..."
  gcloud container clusters resize $CLUSTER_NAME --node-pool=$NODE_POOL_NAME --num-nodes=3 --zone=$ZONE --project=$PROJECT_ID
}

# Check the current time
current_hour=$(date +"%H")

# Set the inactive hours (e.g., 22:00 to 06:00)
inactive_start_hour=22
inactive_end_hour=6

# Check if it's within inactive hours
if [ "$current_hour" -ge "$inactive_start_hour" ] || [ "$current_hour" -lt "$inactive_end_hour" ]; then
  scale_down
else
  scale_up
fi
