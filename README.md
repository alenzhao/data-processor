# data-processor
Script to convert from VCF files to MAF files ready to be imported into cBioPortal

To use - change data directory variables, then simply run (put the header file in whatever directory you run from

### To provision using ansible

    ansible-playbook -v -i .vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory --private-key=~/.vagrant.d/insecure_private_key -u vagrant provisioning.yml
