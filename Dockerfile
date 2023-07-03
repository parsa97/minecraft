FROM python:3.9

ARG VERSION=main
ARG INVENTORY_DIR=inventory
ARG TERRAFORM_VERSION=1.5.2
ENV PLAYBOOK=site.yaml

RUN apt update &&\
    apt install -yy sshpass

ADD https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip /tmp
RUN unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ && rm /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

RUN git clone -b ${VERSION} --single-branch https://github.com/parsa97/minecraft.git

WORKDIR /minecraft

RUN git submodule update --init --recursive &&\
    pip install -r requirements.txt &&\
    ansible-lint roles/

COPY ${INVENTORY_DIR} /minecraft/inventory

ENTRYPOINT [ "/bin/sh", "-c", "ansible-playbook -i inventory/ ${PLAYBOOK} $0" ]
