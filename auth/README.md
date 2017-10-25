# Central Authentication with Ansible Vault

## Add your authentication file to this folder

Format:

```yml
creds:
 username: some_user
 password: some_user_password
 ```

The playbook uses the file secrets.yml, but it can be named anything else, keep in mind to update the ```provider``` task.

```yml
  tasks:
  - name: obtain login credentials
    include_vars: ../auth/secrets.yml
```

Remember to encrypt your authentication file with ```ansible-vault```.