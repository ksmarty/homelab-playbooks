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

Open a new admin powershell and run the following command to setup [WinRM](https://docs.microsoft.com/en-us/windows/win32/winrm/portal) on the host machine.
```ps
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))
```

On the control machine, install pywinrm..
```shell
sudo apt install python3-pip # Install pip if missing
pip install pywinrm
```
