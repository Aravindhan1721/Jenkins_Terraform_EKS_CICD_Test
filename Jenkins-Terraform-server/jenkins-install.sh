#!/bin/bash
sudo apt-get update
yes | sudo apt install openjdk-11-jdk-headless
echo "Waiting for 30 seconds before installing the jenkins package..."
sleep 30
apt-get upgrade -y
apt-get install wget curl unzip -y
apt install openjdk-17-jre-headless -y
apt install net-tools -y
wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update -y
sudo apt-get install jenkins -y

sleep 30
echo "Waiting for 30 seconds before installing the Terraform..."
wget https://releases.hashicorp.com/terraform/1.10.0/terraform_1.10.0_linux_386.zip
yes | sudo apt-get install unzip
sudo unzip -o 'terraform_1.10.0_linux_386.zip'
sudo mv terraform /usr/local/bin/

# Install Kubernetes (v1.30)
sudo apt-get update
# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
# Add Kubernetes repository and key
# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v5.0.4/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
# Install Kubernetes components
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
#(Optional) Enable the kubelet service before running kubeadm
sudo systemctl enable --now kubelet

# Mark Kubernetes packages on hold to prevent updates
sudo apt-mark hold kubelet kubeadm kubectl

# Enable and start kubelet
sudo systemctl enable kubelet
sudo systemctl start kubelet

# Verify installations
echo "Jenkins Version: $(jenkins --version)"
echo "Git Version: $(git --version)"
echo "Terraform Version: $(terraform version)"
echo "Kubernetes Version: $(kubectl version --client)"
