#!/usr/bin/env bash
ansible_vyos_home="/usr/local/share/ansible/vyos"
# If ansible Vault is used: 
# /usr/local/bin/ansible-playbook -vvvvv $ansible_vyos_home/vyos-cli-play.yml --vault-password-file $ansible_vyos_home/auth/vault/vault_pass.py
#
# For full debug use -d. For normal run use -n
if [ $1 = "-d" ]
then
    /usr/local/bin/ansible-playbook -vvvv $ansible_vyos_home/vyos-cli-play.yml
elif [ $1 = "-n" ]
then
   /usr/local/bin/ansible-playbook $ansible_vyos_home/vyos-cli-play.yml
else                                
        echo " Options are -d or -n"
fi                                  