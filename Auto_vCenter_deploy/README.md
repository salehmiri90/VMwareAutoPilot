# Single Touch vCenter Installation
## Description
This repository will help you to do single touch vCenter installation by modifying a variable file in `terraform.tfvars` and then run the code to setup your vCenter very soon. 

## 🎥 Video Demo on Youtube
In near future

## Technologies and Tools
To implement this project, I only used Terraform and VMware vCenter product iso file. This method tested with vCenter 8.  

✅ `Terraform`

✅ `vCenter product iso file`

## Project Requirements
⭐ An ESXi host

⭐ A linux server to run Terraform on it.

⭐ Muont vCenter iso file on your linux server.

## Start to Use this code
### Step 1: Transfer codes to your Server
&#9745; To clone this repository from my GitHub using the command line, you can use the following command:
````
git clone https://github.com/salehmiri90/VMware_Automation.git
````

&#9745; Use the 'cd' command to get into the contents of the cloned directory 'VMware_Automation' and this project realted directory 'Auto_vCenter_deploy' as follows: 
````
cd VMware_Automation/Auto_vCenter_deploy
````

&#9745; And then listing the contents with the command: 
````
ll
````

### Step 2: Defining Variables
&#9745; Modify `terraform.tfvars` file and set the correct variables based on your infrastracture and environment.
````
vim terraform.tfvars
````

&#9745; The `terraform.tfvars` content description is same as below.

| Variable | Description | Value |
| -------- | -------- | -------- |
| binaries_path | Mounted iso path on linux server | /mnt/cdrom | 

### Step 3: Execution
&#9745; Format and Validate codes to download required providers
```
terraform fmt
terraform validate
```

&#9745; Check the changes before impact on infrastructure.
```
terraform plan
```
&#9745; Execute below Terraform command to double check plan then hit `yes` to make changes. 
```
terraform apply
```

# ✍ Contribution
I am confident that working together with skilled individuals like yourself can improve the functionality, efficiency, and overall quality of our projects. Therefore, I would be delighted to see any forks from this project. Please feel free to use this code and share any innovative ideas to enhance it further.

## ☎ Contact information
#### 📧 salehmiri90@gmail.com
#### [Linkedin.com/in/salehmiri](https://www.linkedin.com/in/salehmiri)
