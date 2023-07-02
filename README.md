# Contents
- [Contents](#contents)
- [Summary](#summary)
- [Requirements](#requirements)
- [Quick Start](#quick-start)
- [Quick Start (Docker)](#quick-start-docker)
- [Role tags](#role-tags)
- [Upgrade procedure](#upgrade-procedure)
- [TODO/RoadMAP?](#todoroadmap)

# Summary

A ansible to deploy Minecraft server based on spigot and Bungeecord proxies.

This play contains multiple roles include:
- minecraft: deploy minecraft server based on spigot distro
- bungeecord: deploy bungecord proxies
- grafana: deploy grafana for monitoring
- vsphere: to create virtual machine on vsphere cluster
- prepare: prepare hosts include install basic packages
- lvextend: extend lvm
- docker: to install docker on required hosts
- etcـhosts: to add all hosts in /etc/hosts
- java: install java it's required for bungecord and minecraft server

And we borrowed below roles from [prometheus ansible project](https://github.com/prometheus-community/ansible.git):
- node_exporter: install node_exporter
- prometheus: install prometheus server


# Requirements
- python3.9
- git

# Quick Start


1. Setup all git submodules
```
git submodule update --init --recursive
```

2. Prepare pipenv with
```
pipevn shell
```

3. Install vSphere-Automation-SDK
```
pip install -r requiremens.txt
```

4. Setup inventory
Edit required variables in inventory and add hosts

5. Deploy
```
ansible-playbook -i inventory/ --ask-vault-pass site.yaml
```
# Quick Start (Docker)
1. Build Docker
The default inventory dir is `inventory`
```
docker build . -t minecraft-ansible:latest
```
build custom version with custom inventory dir
```
docker build . -t minecraft-ansible:latest --build-arg 'VERSION=1.0.0' --build-arg 'INVENTORY=myinventorydir'
```
1. Run docker
```
docker run -it -u root --rm minecraft-ansible:latest
```
You can pass playbook args to your docker playbook
```
docker run -it -u root --rm minecraft-ansible:latest --ask-vault-pass -t minecraft
```

# Role tags
Roles tags are exact same with their name.
role | tags
---|---
prometheus | prometheus
minecraft | minecraft

# Upgrade procedure
For minecraft and bungeecord
1. Change version or release in your inventory
2. Run role with extended variable `minecraft_upgrade` or `bungeecord_upgrade`
```
ansible-playbook -i inventory/ --ask-vault-pass site.yaml -e minecraft_upgrade=true
```

# TODO/RoadMAP?
- [ ] Improve config files and create more variable for customization
- [ ] Add post deploy step and verify installation
- [ ] Add preflight checks to validate inputs
- [ ] Add prefered alert rules for prometheus
- [ ] Install plugins for minecraft and bungeecord
- [ ] Add molecule test for roles
- [ ] Support container installation type
- [ ] Add loadbalancer between bungeecord servers
- [ ] Add Antiaffinity for our machines (depend on provider)
- [ ] Add argument_spec to meta (nice to have!)
