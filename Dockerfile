FROM registry.access.redhat.com/rhel7
RUN yum-config-manager --enable rhel-7-server-rpms 
RUN yum install -y perl ;\
yum clean all

