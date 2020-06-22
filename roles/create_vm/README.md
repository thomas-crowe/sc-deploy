# rhv_vm_deployer
Ansible role for deploying virtual machines into OPENTLC RHV clusters

Using this role, administrators can easily and quickly deploy new Virtual Machines into the OPENTLC RHV clusters.  Configuration is done by simply creating a maifest of servers to be created using the following format;

--------------------- Begin Paste -----------------------------
- virtual_machines:
    <VM Name>:
      template: <Name of RHV Template to instantiate from>
      memory: <Memory with unit specifier>
      cpu_cores: <Number of CPU cores per socket>
      cpu_sockets: <Number of CPU sockets>
      cpu_threads: <Number of threads per CPU core>
      fe_nic: <Name of ethernet device for Front-End network>
      fe_ip_address: <IP address of VM for the Front-End network>
      fe_ip_netmask: <Subnet Mask for the Front-End network>
      fe_ip_gateway: <Default route for the Front-End network>
      be_nic: <Name of ethernet device for Back-End network>
      br_ip_address: <IP address of VM for the back-end network>
      be_ip_netmask: <Subnet mask for the back-end network>
      group: <list of Ansible inventory groups to add VM into>

    <Next VM>:
---------------------- End Paste ----------------------------

The virtual machines will be deployed based on the defined configuration in the manifest.  The parameters are defined as follows;

template: The name of the RHV template to be used to instantiate the virtual machine

memory: The amount of memory with the unit specifier for the virtual machine

cpu_cores: Number of CPU cores per socket for the virtual machine
cpu_sockets: Number of CPU sockets to be configured in the virtual machine
cpu_threads: Number of CPU threads per core to be configured for the virtual machine

fe_nic: The name of the front-end ethernet device for the virtual machine
fe_ip_address: The IP address of the front-end NIC for the virtual machine
fe_ip_netmask: The subnet mask for the front-end network
fe_ip_gateway: The default route for the front-end network

be_nic: The name of the back-end ethernet device for the virtual machine
be_ip_address: The IP address of the back-end NIC for the virtual machine
be_ip_netmask: The subnet mask for the back-end network

group: List of Ansible groups this virtual machine should be added to

Once the Virtual Machines are instantiated, the are configured to utilize the OPENTLC Satellite server, have the IPA client software installed, register with the IPA server, perform a software update, reboot, and are available to be additionaly configured using the Ansible groups defined in the manifest.
