# NSXT-CI-CD
This repository will help you to automate vSphere NSXT with DevOps CI/CD pipelines.

# Requirements
**Must-Have:**
1. End-User should be able to self-service Network and Security Services (Routing, Load Balancing, Security Groups, Security Policies, etc.) with minimal or no intervention from the NSX Administrator.
2. The End User should not be able to harm the system ( like removing NSX from a cluster…..)
3. One End-user should not be able to alter other end-users configurations
   
**Nice-to-have:**
1. Have the possibility to expose every NSX features to the end-user, but also to restrict some
2. Ability to version control and roll back end-user configurations
3. The end-user workflow should be easy

# Solution Components
1. The NSXT Admin prepared major devops infrastructure components include Gitlab, Jenkins, Terraform and vault.

    A. Gitlab: https://gitlab01.saleh.miri

    B. Jenkins: https://jenkins01.saleh.miri:8080
  
    C. Vault: https://jenkins01.saleh.miri:8200
  
    D. Terraform: runs on jenkins server

3. Configuring Gitlab and prepare user privillages to commit on master/main branch.
4. Configuring Jenkins to trigger by Gitlab commits.

# Configuration Steps
1. GitLab: Create a new project
2. Jenkins: Create a new project
3. Jenkins: Configure Jenkins and create a pipeline.
4. Vault: Configuring vault and create key pairs.
5. Create NSXT terraform configuration files on Jenkins server under **/var/lib/jenkins/workspace/project-name/** directory.
6. Integrate GitLAB with Jenkins.
7. Commit new changes in GitLab and check Pipeline Execution.

# Real World Execution Scenario (A to Z)
1. User "Azi" as reporter will change the "terraform.tfvars" file which is located on Gitlab server.
2. Due to "Azi" user's privilage on Gitlab, She needs to create fork from main project then edit the file.
3. After editing the file, the "Azi" user will create a merge request to her manager.
4. User "Ben" is the "Azi" manager and has access to merge requestes to main/master branch, he'll do it.
5. After forked requestes merged to the main/master branch, the Gitlab is triggered Jenkins project pipelines.
6. In Jenkins pipeline, the git project get cloned to Jenkins project-name workspace. Actually the "terraform.tfvars" file will download.
7. After that, Terraform connected to Vault and get host,username and password variables .
8. Continue to Jenkins pipeline, terraform format and validate will run.
9. The main important part which is run after abow steps is terraform action with auto approve that apply changes on NSXT.
10.  At the end, the terraform.tfvars" file will delete from project workspace and ready for next run.

**That's All, Have fun!** 

# What will happen next?
In this particular project, I wrote codes to create and modify NSXT Inventory Groups. Please take a look at Youtube video to find out.

# Youtube demo
### 🎥 Video Demo on Youtube
Instruction video is already uploaded to my youtube channel [salehmiri90](https://youtube.com/salehmiri90) and the video names are:
&#9745; `Automating NSXT with CD/CD from zero to hero`

## ✍ Contribution
I am confident that working together with skilled individuals like yourself can improve the functionality, efficiency, and overall quality of our projects. Therefore, I would be delighted to see any forks from this project. Please feel free to use this code and share any innovative ideas to enhance it further.

## ☎ Contact information
#### 📧 salehmiri90@gmail.com
#### [Linkedin.com/in/salehmiri](https://www.linkedin.com/in/salehmiri)
