#!/bin/bash

date

${custom_block}

cat > /root/citc_authorized_keys <<EOF
${citc_keys}
EOF

yum install -y git python3.11

# Install Ansible
mkdir -p /opt/venvs/
python3.11 -m venv /opt/venvs/ansible
/opt/venvs/ansible/bin/pip install "ansible ~= 8.0"

cat > /root/hosts <<EOF
[management]
$(hostname -f) ansible_connection=local ansible_python_interpreter=/usr/bin/python3
EOF

mkdir -p /etc/ansible/facts.d/
echo "{\"csp\":\"${cloud-platform}\", \"fileserver_ip\":\"${fileserver-ip}\", \"mgmt_hostname\":\"${mgmt_hostname}\"}" > /etc/ansible/facts.d/citc.fact


git clone --branch "${ansible_branch}" "${ansible_repo}" /root/citc-ansible

cat >> /root/citc-ansible/group_vars/management.yml <<EOF
waldur_api_url: ${waldur_api_url}
waldur_api_token: ${waldur_api_token}
waldur_order_item_uuid: ${waldur_order_item_uuid}

glauth_admin_uidnumber: ${glauth_admin_uidnumber}
glauth_admin_password: ${glauth_admin_password}
glauth_admin_password_digest: ${glauth_admin_password_digest}
glauth_admin_pgroup: ${glauth_admin_pgroup}
EOF

cat > /root/update_ansible_repo <<EOF
#! /bin/bash
cd /root/citc-ansible
git pull --autostash --rebase
EOF
chmod +x /root/update_ansible_repo

cat > /root/run_ansible <<EOF
#! /bin/bash
cd /root/citc-ansible
source /opt/venvs/ansible/bin/activate
ansible-playbook --inventory=/root/hosts "\$@" management.yml 2>&1 | tee -a /root/ansible-pull.log
EOF
chmod +x /root/run_ansible

/root/run_ansible

date
