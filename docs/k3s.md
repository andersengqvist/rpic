The K3s distribution will be used.
K3s is *The certified Kubernetes distribution built for IoT & Edge computing*[1],
so it will fit our needs perfectly.

Links:
 * https://rancher.com/docs/k3s/latest/en/
 * https://carpie.net/articles/kubernetes-on-raspberry-pi-with-k3s
 * A lot of useful articles: https://carpie.net
 * Even more useful articles: https://dev.to/t/k3s
 * Setup k3s with Ansible:
   - https://github.com/k3s-io/k3s-ansible
   - https://github.com/PyratLabs/ansible-role-k3s
   - https://github.com/ikaruswill/cluster-ansible-roles/tree/master/k3s
 * https://blog.alexellis.io/self-hosting-kubernetes-on-your-raspberry-pi/

# Enable cgroups and iptables
Before installing k3s we must enable cgroups and iptables,
see [Enabling cgroups for Raspbian Buster](https://rancher.com/docs/k3s/latest/en/advanced/#enabling-cgroups-for-raspbian-buster) and [Enabling legacy iptables on Raspbian Buster](https://rancher.com/docs/k3s/latest/en/advanced/#enabling-legacy-iptables-on-raspbian-buster) 
This will be done using Ansible...

# Installing K3s

[1]: https://k3s.io