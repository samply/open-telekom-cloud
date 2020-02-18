# Terraform Provisioning for Resources on Open Telekom Cloud

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

* To build a test instance, being accessible at `https:// (search | auth | mdr) .test.germanbiobanknode.de`:

        terraform workspace new test
        terraform workspace select test
        
* To return to productive instance:

        terraform workspace select default

* Init server, db, networks, ... with:

        terraform init
        terraform plan
        terraform apply
        
* Connect over ssh with user core@ prod=80.158.32.82 or test=80.158.4.11


## Container Linux Images

Our VMs use Container Linux basis images. One can download them [here][2]. The images have to be imported into the OTC Image Management Service. The following steps have to be taken:

* download `coreos_production_openstack_image.img.bz2` from [CoreOS][2]
* unpack the image
* use s3cmd to upload the image to our `coreos.obs.eu-de.otc.t-systems.com` bucket
* create an image in Image Management Service/Private Images
 * select the uploaded images from the bucket
 * do not select any OS
 * select 30 GB as disk size
 * name the image `container-linux-<version>`
 * submit the creation
 

## Managed Postgres Database

The Terraform Module [Postgres][1] describes a managed postgres database resource (RDS). The database is available under the hostname `postgres.openstacklocal`.

### Root Access to the Database 

* Create a SSH tunnel to the database server

```bash
ssh -L 5432:postgres:5432 otc-server-prod
```

* Access the database on localhost with user root

### Create a Database and User

```sql
CREATE DATABASE auth;
CREATE USER auth_user WITH ENCRYPTED PASSWORD '...';
GRANT auth_user TO root;
GRANT ALL PRIVILEGES ON DATABASE auth TO auth_user;
```

## Create New Let's Encrypt Certificate

Check that the certificate isn't already known:

```bash
docker run --rm -v /etc/nginx/ssl:/etc/letsencrypt certbot/certbot:v0.36.0 certificates
```

First do a dry run for each domain:

```bash
docker run -it --rm \
  -v /etc/nginx/ssl:/etc/letsencrypt \
  -v acme-challenge:/certbot \
  certbot/certbot:v0.36.0 \
  certonly --dry-run --agree-tos --webroot --webroot-path /certbot \
  -d <domain>
```

If Nginx is down because of missing certificates, uncomment all server blocks listening to 443.

Than do the same removing `--dry-run`

### Re-destroy

* In the "Volume Backup Service" section choose your previously created backup of `server-data-(test/default)`
* Select "Restore Disk". 
If errors occur, select "Create Disk" with same name and size, search for its id and replace <id>:
```bash
terraform import module.server.opentelekomcloud_blockstorage_volume_v2.data <id>
```
* Apply and restore database

[1]: <https://github.com/samply/open-telekom-cloud/tree/master/modules/postgres>
[2]: <https://coreos.com/releases/>
