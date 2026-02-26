FROM              docker.io/redhat/ubi9
RUN               curl -L -o /etc/yum.repos.d/hashi.repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
RUN               curl -o /etc/yum.repos.d/docker.repo https://download.docker.com/linux/rhel/docker-ce.repo
RUN               dnf install libicu make terraform docker-ce-cli unzip -y
RUN               cd /tmp && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install && rm -rf aws*
RUN               curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /bin/kubectl && chmod +x /bin/kubectl
RUN               useradd chanu-github
USER              chanu-github
WORKDIR           /home/chanu-github
RUN               curl -o actions-runner-linux-x64-2.330.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.330.0/actions-runner-linux-x64-2.330.0.tar.gz && tar xzf ./actions-runner-linux-x64-2.330.0.tar.gz && rm -f actions-runner-linux-x64-2.330.0.tar.gz
COPY              run.sh /
ENTRYPOINT        ["bash", "/run.sh"]