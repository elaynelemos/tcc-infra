# tcc-infra

## Local Scenario Setup
Before continue make sure you have [VirtualBox](https://www.virtualbox.org/wiki/Download_Old_Builds_6_1) and [Vagrant](https://developer.hashicorp.com/vagrant/downloads) installed in your local machine.

1. Config vbox network range:
    ```bash
    sudo vi /etc/vbox/networks.conf

    # paste the following 2 lines
    * 10.0.0.0/8 192.168.0.0/16
    * 2001::/64
    ```
1. Init Ansible environment:
    ```bash
    cd configuration
    ./init.sh
    source .venv/bin/activate
    ansible-galaxy install -r requirements.yml
    ```
1. Build and load the VM with Vagrant:
    ```bash
    vagrant up
    ```

### ⚠️ If you have to run the configuration again, use: `vagrant provision`. It will apply the Ansible configuration in `gector-setup.yml`.
