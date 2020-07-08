# sc-deploy
Supercluster Deployment playbooks

# Install requirements

```pip install ovirt-python-sdk```
```ansible-galaxy collection install oasis_roles.system```


# Create secrets file

Copy the Secure Note from bitward *"SC01 RHV Secrets file"* and save it as `secrets.yaml`

# Configure group vars

Edit `group_vars/all.yaml`

```yaml
virtual_machines:
    satellite:
      template: rhel-7.8-guest
      memory: 256GiB
      memory_max: 256GiB
      memory_guaranteed: 256GiB
      cpu_cores: 8
      cpu_sockets: 2
      cpu_threads: 2
      root_disk_size: 50GiB
      ip_offset: 61
      fe_nic: eth0
      be_nic: eth1
      group: satellite
```

Modify the variable `ip_offset` to the IP address available

# Run playbook 

`ansible-playbook sc-deploy.yaml`
