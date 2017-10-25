#!/bin/bash
ansible_vyos_home="/usr/local/share/ansible/vyos"
#/usr/local/bin/ansible-playbook -vvvvv $ansible_vyos_home/vyos-cli-play.yml --vault-password-file $ansible_vyos_home/auth/vault/vault_pass.py
/usr/bin/ansible-playbook -vvvv $ansible_vyos_home/vyos-cli-play.yml
#/bin/rm $ansible_vyos_home/*.retry
