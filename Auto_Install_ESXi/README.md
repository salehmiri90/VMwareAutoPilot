# ESXi8u1 Automated Installation on Baremetal
This repository provides a fully automated solution for installing the ESXi8u1 operating system on HPE physical servers using iLO. With this code, you can effortlessly deploy ESXi servers by simply completing the variables and running the main playbook on your Ansible server. Say goodbye to manual installation hassles and hello to streamlined and efficient deployment!

## Description
In this code, I’m using Kickstart without PXE to do the ESXi version 8u1 installation over HPE Gen10 Baremetal and do the post configuration to set NTP and etc. 
I wrote custom roles to define the main playbook, so please star this code to easily find it later.

## Technologies and Tools
ESXi installation process can be simplified by means of Kickstart Installation method This method utilizes so called Kickstart File, which describes the configuration, required setup and post installation tasks for Kickstart installation.
Kickstart File can be placed in the remote repository, accessible via NFS, HTTP, FTP, etc…, or can be included in ISO image, which is pretty convenient to store a Kickstart File.

## How it's works
In this tutorial we downloaded original ESXi8u1 ISO image then run one playbook file which has two block and 7 roles to mount iso in the Linux file system, modify it by adding Kickstart File `ks.cfg` and re-pack it to create custom UEFI bootable ESXi8u1 ISO image using `mkisofs` command.

🔔 Notice: The OS disks on bare metal server must exist on the first bays on your physical servers.

My original ISO which I’m using to do below steps was included grub menu modifying as `ins.ks=cdrom:/KS.CFG`

## Why use this project?
⭐ Automate the VM creation and OS installation process

⭐ Save time and effort

⭐ Reduce the risk of human error

## How to use this project?
⭐ Clone the repository to your local machine.

⭐ Install Ansible on your local machine.

⭐ Edit the hosts file to include the IP addresses of the target servers.

⭐ Edit the host_vars and group_vars file to include the required input parameters such as hostname and IP address.

⭐ Run the playbook.

## What does this project contain?
Ansible playbook to automate the installation of ESXi 8u1 on HPE Gen10 bare metal servers
⭐ host_vars file to specify the IP addresses of the target servers.

⭐ group_vars file to specify the required input parameters in each groups such as gateway , iLO authentication and DNS IP address.

## Playbook Steps
&#9745; 1st role: copy-iso-mount

Mounting and copy cdrom items will do in this role.

````yml
mkdir /mnt/{{ item.hostName }}
mount -o loop -t iso9660 {{ isosrc }}/{{ src_iso_file }} /mnt/{{ item.hostName }}/
mkdir {{ file_path }}/{{ item.hostName }}
cp -avRf /mnt/{{ item.hostName }}/* {{ file_path }}/{{ item.hostName }}/
````
&#9745; 2nd role: vm-custome-boot

In this step, I remove boot.cfg file from root and efi/boot directories, then put custom boot file to both destinations.

````yml
rm -f /home/deploy/baremetal/{{ item.hostName }}/boot.cfg
rm -f /home/deploy/baremetal/{{ item.hostName }}/efi/boot/boot.cfg
````

````yml
copy:
          src: BOOT.CFG
          dest: /home/deploy/baremetal/{{ item.hostName }}/
          remote_src: no
          owner: root
          group: root
          mode: '0744'
````

````yml
copy:
          src: BOOT.CFG
          dest: /home/deploy/baremetal/{{ item.hostName }}/efi/boot/
          remote_src: no
          owner: root
          group: root
          mode: '0744'
````

&#9745; 3rd role: vm-ks

In this step the Kickstart content for each host will be create and after that I set some esxi post configuration in this file. For example disable IPv6, set ntp service up and run, set secondary dns ip address will do here. 

````yml
  copy:
          force: yes
          dest: /home/deploy/baremetal/{{ item.hostName }}/KS.CFG
          content: |
                  vmaccepteula
                  clearpart --firstdisk=local --overwritevmfs
                  install --firstdisk=local --overwritevmfs
                  rootpw {{ root_password }}
                  network --bootproto=static --addvmportgroup=1 --vlanid={{ global_vlan_id }} --ip={{ item.esxi_ip }} --netmask={{ global_netmask }} --gateway={{ global_gw }} --nameserver={{ global_dns1 }} --hostname={{ item.hostName }}
                  %firstboot --interpreter=busybox
                  vim-cmd hostsvc/enable_ssh
                  vim-cmd hostsvc/start_ssh
                  vim-cmd hostsvc/enable_esx_shell
                  vim-cmd hostsvc/start_esx_shell
                  esxcli system module parameters set -m tcpip6 -p ipv6=0
                  esxcli network ip set --ipv6-enabled=false
                  esxcli system ntp set --server={{ global_ntp1 }} --server={{ global_ntp2 }}
                  esxcli network ip dns server add --server={{ global_dns2 }}
                  esxcli system ntp set --enabled=true
                  esxcli system ntp start
                  #esxcli system settings advanced set -o /UserVars/HostClientCEIPEnabled -i 0
                  reboot
````

&#9745; 4th role: vm-gen-iso

Using mkisofs command to create an ISO and put on the specific path which can located by nginx webserver.

````yml
  shell: >
          mkisofs
          -o {{ iso_path }}/{{ item.hostName }}.iso
          -relaxed-filenames
          -J
          -R
          -b isolinux.bin
          -c boot.cat
          -no-emul-boot
          -boot-load-size 4
          -boot-info-table
          -eltorito-alt-boot
          -e efiboot.img
          -boot-load-size 1
          -no-emul-boot
          "{{ file_path }}"/{{ item.hostName }}/
````
&#9745; 5th role: iso-uefi

Using isohybrid command to force iso to be compatible with uefi and bios methods. 

````yml
sudo isohybrid --uefi {{ iso_path }}/{{ item.hostName }}.iso
````

&#9745; 6th role: clean-stage

Clear the stage and delete unnecessary files except created ISO files. 

````yml
sudo umount /mnt/{{ item.hostName }}
sudo rm -rf {{ file_path }}/{{ item.hostName }}
sudo rm -rf /mnt/*
````
&#9745; 7th role: ilo-provisioning

Using group_vars to authenticate to HPE iLO and use nginx webserver path to mount related ISO to the iLO media.

````yml
  hpilo_boot:
          host: "{{ item.ilo_ip }}"
          login: "{{ ilo_user }}"
          password: "{{ ilo_pass }}"
          state: "{{ ilo_state }}"
          media: cdrom
          image: http://salehmiri.com:443/{{ item.hostName }}.iso
  delegate_to: localhost
````

## Run Playbook

Run below command to execute playbook.

````
ansible-playbook 00.ilo_iso_esxi.yaml
````

## Requirements

Before using this automation code, make sure you have the following:

🟪 An Ansible server with Ansible installed. If you don't have Ansible installed, refer to the official [Ansible Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/index.html).

🟪 Access to HPE servers with iLO functionality. Ensure that you have the necessary credentials and network connectivity to interact with the iLO interface.

🟪 Familiarity with ESXi and the specific configuration requirements for your environment.

🟪 Complete host_vars and group_vars properly in inventory directory.
````
vi /etc/ansible/inventory/hosts
````

````yml
hosts:
  - hostName: srv33.saleh.miri.local
    esxi_ip: 1.6.29.9
    ilo_ip: 1.18.66.9

  - hostName: srv34.saleh.miri.local
    esxi_ip: 1.6.29.10
    ilo_ip: 1.18.66.10
````

# ✍️ Contribution
I am confident that working together with skilled individuals like yourself can improve the functionality, efficiency, and overall quality of our projects. Therefore, I would be delighted to see any forks from this project. Please feel free to use this code and share any innovative ideas to enhance it further.

## ☎️ Contact information
### 📧 salehmiri90@gmail.com
### [Linkedin.com/in/salehmiri](https://www.linkedin.com/in/salehmiri)
