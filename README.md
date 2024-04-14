# tcc-infra

## Local Scenario Setup

### Dependencies
- Python3
- Virtualbox installation instructions: https://diolinux.com.br/tutoriais/como-instalar-o-virtualbox-no-linux.html
- Vagrant installation instructions: https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-install
- Docker installation instructions: https://docs.docker.com/engine/install

### Configuration
1. Config vbox network range:
    ```bash
    sudo vi /etc/vbox/networks.conf

    # paste the following 2 lines
    * 10.0.0.0/8 192.168.0.0/16
    * 2001::/64
    ```
1. Init Ansible environment:
    ```bash
    cd api-server/configuration
    ./init.sh
    source .venv/bin/activate
    ansible-galaxy install -r requirements.yml
    ```
1. Build and load the VM with Vagrant:
    ```bash
    vagrant up --provision
    ```
1. Provision prometheus with docker:
    ```bash
    # for prometheus configuration, use the prometheus.yaml file
    # at this repository (path below).
    docker run --name prometheus \
      -p 9090:9090 \
      -v client-simulator/configuration/prometheus/prometheus.yaml:/etc/prometheus/prometheus.yml \
      -v prometheus-data:/prometheus \
      prom/prometheus
    ```

### To enter the machine, use: `vagrant ssh`
### ⚠️ If you have to run the configuration again, use: `vagrant provision`. It will apply the Ansible configuration in `gector-setup.yml`.

## Remote Scenario Setup

### Dependencies
- Python3

### Configuration

1. Init Ansible environment:
    ```bash
    cd api-server/configuration
    ./init.sh
    source .venv/bin/activate
    ansible-galaxy install -r requirements.yml
    ```
1. Add SSH Key for remote host to agent:
    ```bash
    ssh-add <PATH_TO_SSH_PRIVATE_KEY>
    ```
1. Enter the remote configuration at inventory file:
    ```ini
    gector-api-server ansible_user=ubuntu ansible_host=<REMOTE_ADDRESS> ansible_port=22
    ```
1. Execute configuration:
    ```bash
    ansible-playbook gector-setup.yml -i inventory -v
    ```

## Simulation
You can find the simulation procedure and scripts at: https://github.com/elaynelemos/gector-client-simulator .

### Sample example
Try the GECToR API, the sentence has to be in M2 format:
```bash
curl -X POST -H "Content-Type: application/json" -d '{"sentence": "In conclusion , although the unsafe online environment , spend too much time on internet may be the potential negative factors of using online social networks .\n"}' http://<SERVER_ADDRESS>/correct
```
