# homelab-playbooks
Ansible playbooks for my homelab

## Prerequisites

Install git on the Ansible controller and clone this repo.

```sh
sudo apt install git
git clone https://github.com/ksmarty/homelab-playbooks.git
cd homelab-playbooks
```

### Linux Setup

Enable sudo for another user:

```sh
usermod -aG sudo <example_user>
```


### Windows Setup

On the Ansible controller, install pywinrm and generate the certs.
```sh
sudo apt install python3-pip # Install pip if missing
pip install pywinrm
./scripts/generate_winrm.sh
```

On the Windows host, open a new admin PowerShell window and run the following command to copy the certificate and setup [WinRM](https://docs.microsoft.com/en-us/windows/win32/winrm/portal):
```ps
iwr -useb https://gitcdn.link/cdn/ksmarty/homelab-playbooks/main/scripts/setup_certs.ps1|iex
```

## Setup

Run the desired playbook.

```sh
ansible-playbook playbooks/<name>.yaml
```

### Windows

If Bluetooth isn't working, follow the steps found [here](https://www.reddit.com/r/ASUS/comments/he7ci7/comment/g1przej/?utm_source=share&utm_medium=web2x&context=3).

> 1. Turn off the PC.
> 2. Unplug power cable to PSU.
> 3. Hold power button for 30 seconds.
> 4. Plug power back into PSU.
> 5. Boot PC.
