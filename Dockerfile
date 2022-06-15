FROM ubuntu:18.04
RUN apt-get update -qq -y &&apt install  openssh-server -y
RUN echo 'root:toor' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
CMD ['/usr/sbin/sshd', '-D']
