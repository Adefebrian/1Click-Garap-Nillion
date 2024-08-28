#!/bin/bash

echo "Welcome to the 1-click installer for Nillion by Airdrop Sultan!"
echo "Before you begin, please join our community on Telegram: t.me/airdropsultanindonesia"
echo "This script will guide you through the process of setting up Nillion Accuser on your machine."

echo "Pausing for 1 minute to allow you to join the Telegram group..."
sleep 60

echo "Installing Docker..."
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm get-docker.sh

echo "Pulling Nillion Docker Image..."
docker pull nillion/retailtoken-accuser:v1.0.0

echo "Creating directory for Nillion Accuser..."
mkdir -p nillion/accuser

echo "Initializing Nillion Accuser..."
docker run -v $(pwd)/nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 initialise

echo -e "\nPlease use the following address to get the faucet: \n$(cat $(pwd)/nillion/accuser/credentials.json | grep 'address') \n\nVisit: https://faucet.testnet.nillion.com/"

echo -e "\nWaiting for 30-60 minutes. Please wait until the process completes before proceeding."
sleep 3600  

echo "Running the Accuser command..."
docker run -v $(pwd)/nillion/accuser:/var/tmp nillion/retailtoken-accuser:v1.0.0 accuse --rpc-endpoint "http://65.109.222.111:26657" --block-start 5052768

read -p "Do you want to backup your wallet? (y/n): " backup_wallet
if [ "$backup_wallet" == "y" ]; then
  cat $(pwd)/nillion/accuser/credentials.json
fi

echo -e "\nThis script was created by Brian, founder of Airdrop Sultan."
echo "Join the community: t.me/airdropsultanindonesia"
echo "Follow on Twitter: x.com/brianeedsleep"
