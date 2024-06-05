#!/bin/bash
# Author         : Christo Deale
# Date	         : 2024-06-05
# rhel9_javasetup: Utility to setup & configure JAVA 8,17 & 21

# Update the package repository
sudo dnf update -y

# Install the specified Java versions
sudo dnf install java-1.8.0-openjdk-devel -y
sudo dnf install java-17-openjdk -y
sudo dnf install java-21-openjdk -y

# Function to configure alternatives for java and javac
configure_alternatives() {
    local version=$1
    local priority=$2

    sudo alternatives --install /usr/bin/java java /usr/lib/jvm/jre-${version}-openjdk/bin/java ${priority}
    sudo alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-${version}-openjdk/bin/javac ${priority}
}

# Configure alternatives for each Java version
configure_alternatives 1.8.0 180
configure_alternatives 17 170
configure_alternatives 21 210

# Prompt the admin to select the default Java version
echo "Please select the default Java version:"
sudo alternatives --config java

echo "Please select the default Java compiler version:"
sudo alternatives --config javac

# Verify the installation
java -version
javac -version
