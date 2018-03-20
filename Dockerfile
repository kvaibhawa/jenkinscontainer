FROM ubuntu:14.04
 
#Setup basic environment
ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 LC_ALL=C.UTF-8 LANGUAGE=en_US.UTF-8

#Update system and install packages
RUN [ "apt-get", "-q", "update" ]
RUN [ "apt-get", "-qy", "--force-yes", "upgrade" ]
RUN [ "apt-get", "-qy", "--force-yes", "dist-upgrade" ]
RUN [ "apt-get", "install", "-qy", "--force-yes", \
      "perl", \
      "build-essential", \
      "cpanminus" ]
RUN [ "apt-get", "clean" ]
RUN [ "rm", "-rf", "/var/lib/apt/lists/*", "/tmp/*", "/var/tmp/*" ]

#Install cpan modules
RUN ["cpanm", "Proc::ProcessTable", "Data::Dumper" ]

# Install dependencies python
RUN apt-get update && apt-get install -y \
    php5-mcrypt \
    python-pip
    
RUN pip install awscli

RUN aws s3 cp s3://perlcontainertest/perlcontainertest.pl .

#Copy script.pl and  make executable
COPY [ "./ps.pl", "/app/ps.pl" ]
RUN [ "chmod", "+x",  "/app/ps.pl" ]

#Set entrypoint of script.pl
ENTRYPOINT [ "/app/ps.pl" ]
