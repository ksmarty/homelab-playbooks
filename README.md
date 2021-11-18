# homelab-playbooks
Ansible playbooks for my homelab

## Prerequisites

### Linux Setup

Allow SSH access for root or enable sudo for another user:
```sh
sed -ri 's/#?(PermitRootLogin).*/\1 yes/' /etc/ssh/sshd_config && service ssh restart
```

```sh
usermod -aG sudo <example_user>
```


### Windows Setup

On the ansible server, install pywinrm and generate the certs.
```shell
sudo apt install python3-pip # Install pip if missing
pip install pywinrm
curl https://raw.githubusercontent.com/ksmarty/homelab-playbooks/main/scripts/generate_winrm.sh | bash
```

On the Windows host, open a new admin PowerShell window and run the following command to copy the certificate and setup [WinRM](https://docs.microsoft.com/en-us/windows/win32/winrm/portal):
```ps
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ksmarty/homelab-playbooks/main/scripts/setup_certs.ps1'))
```

## Setup

### Windows

If Bluetooth isn't working, follow the steps found [here](https://www.reddit.com/r/ASUS/comments/he7ci7/comment/g1przej/?utm_source=share&utm_medium=web2x&context=3).

> 1. Turn off the PC.
> 2. Unplug power cable to PSU.
> 3. Hold power button for 30 seconds.
> 4. Plug power back into PSU.
> 5. Boot PC.
