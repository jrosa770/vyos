# README #

# VyOs Playbook for CLI

### Purpose

* Run multiple tasks out of one playbook
* Control of playbook functions via one common vars file
* Quick runs of routine tasks on Junos based devices
* Control of task via variable task: in play_vars.yml. Example: task: banner will activate vyos_config-banner.yml. Separate vars files are avialble if needed in ```vars\task_bars```.
* The playbook is set to run up to 2 tasks but it can be expanded if needed.


```tree
├── archive
│   └── empty.txt
├── backup
│   └── empty.txt
├── bin
│   └── run_vyos-play.bash
├── config_partial
│   ├── basic_ebgp
│   │   └── empty.txt
│   ├── basic_ibgp
│   │   └── empty.txt
│   ├── ntp.cfg
│   ├── pre-login_banner.cfg
│   ├── vyos_bond
│   │   └── empty.txt
│   ├── vyos_br
│   │   └── empty.txt
│   └── vyos_user
│       └── empty.txt
├── diffs
│   └── empty.txt
├── play_results
│   └── empty.txt
├── rancid
│   ├── vlogin
│   └── vrancid
├── README.md
├── tasks
│   ├── vyos_config-banner.yml
│   ├── vyos_config-basic_ebgp.yml
│   ├── vyos_config-basic_ibgp.yml
│   ├── vyos_config-bond.yml
│   ├── vyos_config-br.yml
│   ├── vyos_config-config_backup.yml
│   ├── vyos_config-interface.yml
│   ├── vyos_config-l3_interface.yml
│   ├── vyos_config-ntp.yml
│   ├── vyos_config-static_rt.yml
│   ├── vyos_config-system.yml
│   └── vyos_config-user.yml
├── templates
│   ├── basic_ebgp.j2
│   ├── basic_ibgp.j2
│   ├── vyos_bond.j2
│   ├── vyos_br.j2
│   └── vyos_user.j2
├── vars
│   ├── play_vars.yml
│   └── task_vars
│       ├── banner.yml
│       ├── basic_ebgp.yml
│       ├── basic_ibgp.yml
│       ├── bond.yml
│       ├── br.yml
│       ├── interface.yml
│       ├── l3_interface.yml
│       ├── static_rt.yml
│       ├── system.yml
│       ├── user.yml
│       ├── vy_int_aggregate.yml
│       ├── vy_l3_int_aggregate.yml
│       └── vy_static_aggregate.yml
├── vyos-cli-play.yml
└── vyos-get_facts.yml
```
### Dependencies

* Ansible (Of course...)
* Ansible Vault
* ansible-napalm (Provides better set based configuration file based merge support than the native Ansible ```vyos_config``` module)

### Main Playbook

```yml
---
- hosts: vyos
  gather_facts: yes
  connection: local
  ignore_errors: yes

  tasks:
  - name: obtain login credentials
    include_vars: ../auth/secrets.yml

  - name: define provider
    set_fact:
      provider:
        host: "{{ inventory_hostname }}"
        username: "{{ creds['username'] }}"
        password: "{{ creds['password'] }}"

  - name: obtain playbook variables
    include_vars: vars/play_vars.yml

  - name: Running task {{ task1 }} # Primary Task
    include: tasks/vyos_config-{{ task1 }}.yml
    when: task1 is defined

  - name: Running task {{ task2 }} # Secondary Task
    include: tasks/vyos_config-{{ task2 }}.yml
    when: task2 is defined
```

### Task Control

The task is controlled by the ```task[#]:``` variable in ```vars/play_vars.yml```. When ```vars/play_vars.yml``` is called by the variable ```task[#]:``` it affects ```include: tasks/vyos_config-{{ task[#] }}.yml```, thus running the needed task for the playbook.