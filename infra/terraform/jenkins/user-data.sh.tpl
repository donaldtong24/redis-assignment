#!/bin/bash
set -euxo pipefail

dnf update -y
dnf install -y docker git java-17-amazon-corretto

systemctl enable docker --now
usermod -aG docker ec2-user

# Jenkins
curl -fsSL -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
dnf install -y jenkins
usermod -aG docker jenkins
systemctl enable jenkins --now

# Trivy (image scanning)
cat > /etc/yum.repos.d/trivy.repo <<'EOF'
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://aquasecurity.github.io/trivy-repo/rpm/public.key
EOF
dnf install -y trivy
