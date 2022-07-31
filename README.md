# Terraform-Azure-OpenVPN

## OpenVPN on Azure using Terraform

### How to build

A terraform version of >0.13 is required.

1. Clone the repo
  ```
  $ git clone https://github.com/Fyrepit/Terraform-Azure-OpenVPN.git
  $ cd Terraform-Azure-OpenVPN.git
  ```

2. Update **terraform.tfvars** with the inputs (if required).

3. Initialize Terraform. This will also download the latest terraform oci provider.

  ```
  $ terraform init
  ```
4. Run terraform plan.

  ```
  $ terraform plan
  ```

5. Run terraform apply to create the infrastructure.

  ```
  $ terraform apply
  ```
 
  When you’re prompted to confirm the action, enter **yes**.

  When all components have been created, Terraform displays a completion message.


6. If you want to delete the infrastructure, run:

  ```
  $ terraform destroy
  ```

  When you’re prompted to confirm the action, enter **yes**.
  

### Installation details
The installation of openvpn is done using openvpn-install.sh script download from [Github](https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh). After installation, the installation log can be checked on VM at /tmp/openvpn-install_${timestamp}.log . For example openvpn-install_2022-07-28-13-14-29.log

### Post-install validation

Confirm that the OpenVPN service is up and running by checking its status using the following command 
  ```
  $ sudo systemctl status openvpn
  ```

Confirm that the OpenVPN daemon is listening on the port instructed
  ```
  $ sudo ss -tupln | grep openvpn
  ```


Check your network interfaces, a new interface has been created for a VPN tunnel.

  ```
  $ ip add
  ```

Check if the client VPN file is create. This file can be downloaded to test the connection from client

  ```
  $ ls -rlt /root/client.ovpn
  ```

### Create additional clients

For creating additonal client, login to the VM as root and execute the openvpn-install.sh script under /home/ubuntu 

  ```
  Login as root
    
    ssh ubunut@<IP of VM>
    ubuntu@ovpn-vm:/home$ sudo -s
    
    root@ovpn-vm:~# bash openvpn-install.sh
    Welcome to OpenVPN-install!
    The git repository is available at: https://github.com/angristan/openvpn-install
    
    It looks like OpenVPN is already installed.
    
    What do you want to do?
       1) Add a new user
       2) Revoke existing user
       3) Remove OpenVPN
       4) Exit
    Select an option [1-4]: 
  ```
