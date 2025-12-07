# Ansible
Ansible is used to configure each node in the cluster.
All Ansible files are stored under the `ansible/` directory.

Links:
 * http://www.hietala.org/automating-raspberry-pi-setup-with-ansible.html
 * https://github.com/rhietala/raspberry-ansible
 * https://hackernoon.com/building-cheap-raspberry-pi-cluster-from-scratch-uf1f3u7z
 * https://www.dinofizzotti.com/blog/2020-04-10-raspberry-pi-cluster-part-1-provisioning-with-ansible-and-temperature-monitoring-using-prometheus-and-grafana/

# The hosts file
The `ansible/hosts` file lists all hosts in the cluster.
It is what Ansible calls an inventory file.

The `[rpic_all]` is the group of all nodes in the cluster.
Under that, on each line, is every node listed.
First is the alias of the node, conveniently the same as the hostname.
Then the ip address and finally the `ethernet_host` variable.
Every rpi is connected to each other through a switch, and the `ethernet_host` lists the wired ip address for each rpi.

`[rpic_all:vars]` lists variables common to all nodes in the `[rpic_all]` group.
The `ansible_ssh_private_key_file` variable points to the key file generated previously.
So now we can run Ansible without providing password to each node.

# Setup
The `ansible/setup.yml` playbook is for setting up and configuring each host.
It basically just delegates to the setup role.
Currently the setup will do the following:

 * Setup the network
   - assign hostname to each node
   - setup the ethernet ip
   - update the hosts file with ip address and hostname of every other node in the cluster
 * Setup ssh between nodes
   - Generate keys for each node
   - Copy keys between each other node
   - Add each node to known hosts
 * Disable bluetooth

A lot has been taken from https://github.com/ikaruswill/cluster-ansible-roles,
especially "Setup ssh between nodes", which can be found here https://github.com/ikaruswill/cluster-ansible-roles/blob/master/ssh/tasks/main.yml.
The "Setup ssh between nodes" step would be a real pain to do manually.
