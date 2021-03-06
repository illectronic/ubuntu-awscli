FROM ubuntu:16.04

# Run the Update
RUN apt-get update && apt-get upgrade -y

# Install pre-reqs
RUN apt-get install -y python curl openssh-server docker.io

# Setup sshd
RUN mkdir -p /var/run/sshd
RUN echo 'root:password' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# download and install pip
RUN curl -sO https://bootstrap.pypa.io/get-pip.py
RUN python get-pip.py

# install AWS CLI
RUN pip install awscli

# Setup AWS CLI Command Completion
RUN echo complete -C '/usr/local/bin/aws_completer' aws >> ~/.bashrc

CMD /usr/sbin/sshd -D

EXPOSE 22
