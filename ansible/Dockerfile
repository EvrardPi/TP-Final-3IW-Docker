FROM webdevops/ansible

RUN apt update && apt install sudo nano ansible ssh openssh-server sshpass -y

WORKDIR /root

COPY ./playbook_example.yml /root/playbook_example.yml

COPY ./hosts /etc/ansible/hosts
