#!/bin/bash

# Define your instance ID and region
INSTANCE_ID="instance_id"  # Replace with your EC2 instance ID
REGION="us-east-1"  # Replace with your region

# Check the current state of the instance
STATE=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].Instances[0].State.Name" --output text --region $REGION)

# Stop the instance if it is running
if [ "$STATE" == "running" ]; then
  echo "Stopping instance $INSTANCE_ID..."
  aws ec2 stop-instances --instance-ids $INSTANCE_ID --region $REGION
  echo "Waiting for the instance to stop..."
  aws ec2 wait instance-stopped --instance-ids $INSTANCE_ID --region $REGION
  echo "Instance has been stopped."
else
  echo "Instance is not running, no action taken."
fi


#provide execution permission chmod +x stop_instance.sh
#set up cronjob using crontab -e
#add cronjob # m h dom mon dow command
#              0 22 * * * /path/to/stop_instance.sh
