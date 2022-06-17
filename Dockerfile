FROM ubuntu:18.04
RUN apt-get update -qq -y &&apt install  openssh-server -y
RUN mkdir -p /var/run/sshd

RUN sed -ri 's/#\?PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config
RUN sed -i 's/#\?PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN groupadd sshgroup && useradd -ms /bin/bash -g sshgroup user


RUN mkdir -p /home/user/.ssh

COPY id_rsa.pub /home/user/.ssh/authorized_keys
 
RUN chown user:sshgroup /home/user/.ssh/authorized_keys && chmod 600 /home/user/.ssh/authorized_keys



RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

RUN service ssh restart
CMD ["/usr/sbin/sshd", "-D"]
