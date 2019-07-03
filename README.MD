
* An already authorized user must create an user at https://console.otc.t-systems.com/iam/users with "password at first login" for dashboard access,
next steps are for new user:


* Create terraform-username at https://console.otc.t-systems.com/iam/users to get access key id and secret for terraform access

* Save as environment in ~\.bash_profile or ~\.bashrc or Windows-Umgebungsvariablen (restart) like:

        export TF_VAR_otc_access_key='sfwr2334c4'
        export TF_VAR_otc_secret_key='gertg245f5435f5ervtrete'
        export TF_VAR_db_passwd='rwevt43' -->Ask an ITC
        export AWS_ACCESS_KEY_ID='sfwr2334c4'
        export AWS_SECRET_ACCESS_KEY='gertg245f5435f5ervtrete'

* Install Terraform, see terraform.io (windows need environment entry, behind proxy set HTTP_PROXY=http://XXX:XX)

* Checkout repo

        git clone https://github.com/samply/open-telekom-cloud.git
        cd open-telekom-cloud

* Add your ssh key as ignition_user and at this user to ignition_config of server for ssh access to server (main.tf)



* Init server, db, networks, ... with:

        terraform init
        terraform plan -var "vpc_name=vpc-prod"
        terraform apply -var "vpc_name=vpc-prod"
        
* Connect to server over ssh using your username: prod=80.158.32.82, test=80.158.36.176

* Test server e.g. with

        docker run -it --rm -p 8888:8080 tomcat:8.0
        
and open http://80.158.32.82:8888 or http://80.158.36.176:8888


* Destroy everything (time is money)

        terraform destroy -var "vpc_name=vpc-prod"
