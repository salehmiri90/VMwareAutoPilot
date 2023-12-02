# NSXT-CI-CD
## Description
This repository will help you to automate vSphere NSXT with DevOps CI/CD pipelines and help you to create same pipelines from other possible requirements on NSXT.
In this particular project, I wrote codes to create and modify NSXT Inventory Groups. Please take a look at Youtube video to find out.

## 🎥 Video Demo on Youtube
Instruction video is already uploaded to my youtube channel [salehmiri90](https://youtube.com/salehmiri90) and the video names are:

&#9745; `Automating NSXT with CD/CD from zero to hero`

## Technologies and Tools
To implement this project, I used NSXT, Gitlab, Jenkins, Terraform and Hashicorp Vault and the URLs are as below.

✅ Gitlab `https://gitlab01.saleh.miri`

✅ Jenkins `https://jenkins01.saleh.miri:8080`

✅ Vault `https://jenkins01.saleh.miri:8200`

✅ Terraform runs on jenkins server.

✅ NSXT `https://nsxt.vi.saleh.miri`

## Project Requirements
⭐ End-User should be able to self-service Network and Security Services (Routing, Load Balancing, Security Groups, Security Policies, etc.) with minimal or no intervention from the NSX Administrator.

⭐ The End User should not be able to harm the system ( like removing NSX from a cluster…..)

⭐ One End-user should not be able to alter other end-users configurations
   
⭐ Have the possibility to expose every NSX features to the end-user, but also to restrict some

⭐ Ability to version control and roll back end-user configurations

⭐ The end-user workflow should be easy

## Solution Components
&#9745; The NSXT Admin prepared major devops infrastructure components include Gitlab, Jenkins, Terraform and vault.

&#9745; Configuring Gitlab and prepare user privillages to commit on master or main branches.

&#9745; Configuring Jenkins to trigger by Gitlab commits.

## Configuration Steps
✅ GitLab: Create a new project.

✅ Jenkins: Create a new project.

✅ Jenkins: Configure Jenkins and create a pipeline.

✅ Vault: Configuring vault and create key pairs.

✅ Create NSXT terraform configuration files on Jenkins server under `/var/lib/jenkins/workspace/project-name/` directory.

✅ Integrate GitLAB with Jenkins.

✅ Commit new changes in GitLab and check Pipeline Execution.

## Real World Execution Scenario (A to Z)
&#9745; 1. User `Azi` as reporter will change the `terraform.tfvars` file which is located on Gitlab server.

&#9745; 2. Due to `Azi` user's privilage on Gitlab, She needs to create fork from main project then edit the file.

&#9745; 3. After editing the file, the `Azi` user will create a merge request to her manager.

&#9745; 4. User `Ben` is the `Azi` manager and has access to merge requestes to main or master branch, he'll do it.

&#9745; 5. After forked requestes merged to the main/master branch, the Gitlab is triggered Jenkins project pipelines.

&#9745; 6. In Jenkins pipeline, the git project get cloned to Jenkins project-name workspace. Actually the `terraform.tfvars` file will download.

&#9745; 7. After that, Terraform connected to Vault and get host,username and password variables .

&#9745; 8. Continue to Jenkins pipeline, terraform format and validate will run.

&#9745; 9. The main important part which is run after abow steps is terraform action with auto approve that apply changes on NSXT.

&#9745; 10. At the end, the terraform.tfvars" file will delete from project workspace and ready for next run.

**That's All, Have fun!** 

# ✍ Contribution
I am confident that working together with skilled individuals like yourself can improve the functionality, efficiency, and overall quality of our projects. Therefore, I would be delighted to see any forks from this project. Please feel free to use this code and share any innovative ideas to enhance it further.

## ☎ Contact information
#### 📧 salehmiri90@gmail.com
#### [Linkedin.com/in/salehmiri](https://www.linkedin.com/in/salehmiri)
