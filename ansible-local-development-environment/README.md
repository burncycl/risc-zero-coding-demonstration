### 2022/10 Michael Grate 

Automation to manage my Linux (Ubuntu) Dev Environment. Note: This is Ubuntu centric.

Ubuntu Prerequisites (or as root)
```
sudo apt-add-repository universe
sudo apt update
sudo apt install -y git ansible make
```

Manually, make sure your user is a sudoer

/etc/sudoers
```
username ALL=(ALL:ALL) ALL
```

Configure Git
```
git config --global user.email "your@email.com"
git config --global user.name "username"
```

Important: Be sure to update ./base/group_vars/all.yml user variable to match your username where automation will be ran.

What's cool about this automation, is it allows you to store you secrets (e.g. AWS Cloud credentials + ssh keys) in source control. This also version controls your local development environment.

### Import AWS user secrets into Ansible automation

Take Access key ID & Secret access key and input them into ansible-vault secrets.yml

If file already exists
```
ansible-vault edit ./base/secrets.yml
```

If doesn't exist, copy from example, edit and update the variable, encrypt.
```
cp secrets.yml.example secrets.yml
vi secrets.yml
ansible-vault encrypt secrets.yml
```

Support also exists for GCP Cloud Credentials, although not enabled.

Example
[secrets.yml.example](./secrets.yml.example)

### Deploy local dev environemnt with all the bells and whistles

Push button magic with
```
make env
```

