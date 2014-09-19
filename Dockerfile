# dockerfile
FROM centos:centos6
MAINTAINER fly0wing <fly0wing@126.com>


# Add a "Message of the Day" to help identify container when logging in via SSH
RUN echo '[ CentOS ]' > /etc/motd

# Import the Centos-6 RPM GPG key to prevent warnings 
RUN rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-6

# Add EPEL Repository
RUN rpm --import http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Install packages and set up sshd
RUN yum -y install \
    vim-minimal \
    sudo \
    openssh \
    openssh-server \
    openssh-clients \
    python-pip



RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key && ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config

# Add scripts
RUN rpm -i http://dl.fedoraproject.org/pub/epel/6/x86_64/pwgen-2.06-5.el6.x86_64.rpm

# wget
RUN yum -y install wget

# Clean up
RUN yum clean all

EXPOSE 22