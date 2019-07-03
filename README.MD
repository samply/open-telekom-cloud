create user https://console.otc.t-systems.com/iam/users with password at first login for dashboard access

* Create terraform-username at https://console.otc.t-systems.com/iam/users to get access key id and secret for terraform access

* save as environment in ~\.bash_profile or ~\.bashrc like:

        export TF_VAR_otc_access_key='sfwr2334c4'
        export TF_VAR_otc_secret_key='gertg245f5435f5ervtrete'
        export TF_VAR_db_passwd='rwevt43' -->Ask an ITC
        export AWS_ACCESS_KEY_ID='sfwr2334c4'
        export AWS_SECRET_ACCESS_KEY='gertg245f5435f5ervtrete'

* (WINDOWS):

        save as Umgebungsvariablen, e.g with 'setx TF_VAR_otc_access_key='sfwr2334c4'' ....

* Install Terraform, see terraform.io

* (WINDOWS):
        save terraform path to Umgebungsvariablen PATH, HTTP_PROXY as well.

* checkout repo

        git clone https://github.com/samply/open-telekom-cloud.git
        cd open-telekom-cloud

* add your ssh key as ignition_user and at this user to ignition_config of server for ssh access to server (main.tf)


* init server, db, networks, ...

        git clone https://github.com/samply/open-telekom-cloud.git
        cd open-telekom-cloud

        terraform init
        terraform plan -var "vpc_name=vpc-prod"
        terraform apply -var "vpc_name=vpc-prod"

* destroy everything (time is money)

        terraform destroy -var "vpc_name=vpc-prod"