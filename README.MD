
To create server and db:
* Create user at https://console.otc.t-systems.com/iam/users to get access key and secret and save to bashrc.. as environment 
* Install Terraform (sudo snap install terraform)
* init server, db     
        git clone https://github.com/samply/open-telekom-cloud.git
        cd open-telekom-cloud
        terraform init
        terraform plan -var 'vpc_name=vpc-prod'
        terraform apply -var 'vpc_name=vpc-prod'
        terraform destroy -var 'vpc_name=vpc-prod'