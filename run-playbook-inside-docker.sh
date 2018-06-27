#!/bin/bash

set -e

cp /etc/ansible/ansible.cfg ansible.cfg
sed -i 's/#retry_files_enabled = False/retry_files_enabled = False/' ansible.cfg
sed -i 's@#control_path_dir = ~/.ansible/cp@control_path_dir = '"$(pwd)"'/.ansible/cp@' ansible.cfg
echo "target ansible_host=${ANSIBLE_HOST} ansible_port=22 ansible_user=${ANSIBLE_USER} ansible_ssh_private_key_file=${ANSIBLE_KEY}" > target
ansible-playbook -i target "${ANSIBLE_PLAYBOOK}" \
         --ssh-extra-args "-o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
