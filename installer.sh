#!/usr/bin/env bash

echo "---------- Running installer for system ----------"

brew_installer(){

  if ! command -v brew &> /dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      (echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile

      echo "exit the shell to finish the brew setup"
  else
      echo "Homebrew is already installed."
  fi
}

# Function to check if Homebrew is installed
check_brew_installed() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew."
        brew_installer
    else
      echo "Homebrew is already installed"
    fi
}

install_intellij(){
  check_brew_installed
  brew install --cask intellij-idea

  if brew list --cask | grep -q 'intellij-idea'; then
      echo "IntelliJ IDEA is sucessfully installed."
  else
      echo "Installation failed. Installing IntelliJ IDEA again..."
      brew install --cask intellij-idea
  fi
}


check_intellij() {
    if [ -d "/Applications/IntelliJ IDEA.app" ]; then
        echo "IntelliJ is already installed."
    else
        echo "IntelliJ is not installed. Installing IntelliJ..."
        install_intellij
    fi
}

check_intellij

# Function to tap the HashiCorp repository
tap_hashicorp() {
    echo "Tapping the HashiCorp repository..."
    brew tap hashicorp/tap

    if [[ $? -eq 0 ]]; then
        echo "Successfully tapped the HashiCorp repository."
    else
        echo "Failed to tap the HashiCorp repository."
        exit 1
    fi
}

# Function to install Terraform
install_terraform() {
    echo "Installing Terraform..."
    brew install hashicorp/tap/terraform

    if [[ $? -eq 0 ]]; then
        echo "Terraform has been installed successfully."
    else
        echo "Failed to install Terraform."
        exit 1
    fi
}

# Function to update Homebrew
update_brew() {
    echo "Updating Homebrew..."
    brew update

    if [[ $? -eq 0 ]]; then
        echo "Homebrew has been updated successfully."
    else
        echo "Failed to update Homebrew."
        exit 1
    fi
}

# Function to upgrade Terraform
upgrade_terraform() {
    echo "Upgrading Terraform..."
    brew upgrade hashicorp/tap/terraform

    if [[ $? -eq 0 ]]; then
        echo "Terraform has been upgraded successfully."
    else
        echo "Failed to upgrade Terraform."
        exit 1
    fi
}

# Function to verify Terraform installation
verify_terraform() {
    if command -v terraform &> /dev/null; then
        echo "Terraform is installed: $(terraform -version)"
    else
        echo "Terraform is not installed. Installing terraform"
        check_brew_installed
        tap_hashicorp
        install_terraform
        update_brew
        upgrade_terraform
        terraform -install-autocomplete
    fi
}

verify_terraform

check_kubectl_installed() {
    if ! command -v kubectl &> /dev/null; then
        echo "kubectl is not installed. Installing it now."
        brew install kubectl
        kubectl version --client
    else
        echo "Kubectl is already installed"
    fi
}

check_kubectl_installed

check_kubectx_installed() {
    if ! command -v kubectx &> /dev/null; then
        echo "kubectx is not installed. Installing it now."
        brew install kubectx
        kubectl version --client
    else
        echo "kubectx is already installed"
    fi
}

check_kubectx_installed

# Function to install TextMate using Homebrew
install_textmate() {
    # Check if Homebrew is installed
    check_brew_installed
    # Install TextMate using Homebrew
    brew install --cask textmate

    # Verify installation
    if [ -d "/Applications/TextMate.app" ]; then
        echo "TextMate has been successfully installed."
    else
        echo "Failed to install TextMate."
    fi
}

check_textmate() {
    if [ -d "/Applications/TextMate.app" ]; then
        echo "TextMate is already installed."
    else
        echo "TextMate is not installed. Installing TextMate..."
        install_textmate
    fi
}

# Run the check_textmate function
check_textmate

check_helm_installed() {
    if ! command -v helm &> /dev/null; then
        echo "helm is not installed. Installing it now."
        check_brew_installed

        brew install helm
        helm version
    else
        echo "helm is already installed"
    fi
}

check_helm_installed

check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        echo "docker is not installed. Installing it now."
        check_brew_installed

        brew install --cask docker
        docker version
    else
        echo "docker is already installed"
    fi
}
check_docker_installed

check_iterm_installed() {
    if ! command -v iterm &> /dev/null; then
        echo "docker is not installed. Installing it now."
        check_brew_installed

        brew install --cask iterm2
        iterm2 version
    else
        echo "iterm2 is already installed"
    fi
}
check_iterm_installed

echo "INSTALL terraform_switch or tfenv MANUALLY as per your need"
echo "INSTALL PYTHON MANUALLY"
echo "INSTALL GCLOUD MANUALLY"
