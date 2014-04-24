FROM ubuntu:precise
MAINTAINER Kevin Manley <kevin.manley@gmail.com> 

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Check we've got the lastest distr
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
# update the box
RUN apt-get update

RUN apt-get install -y wget language-pack-en
RUN locale-gen en_US

RUN apt-get install -y curl git bzr mercurial tree 

RUN apt-get install -y openssh-server

# Create OpenSSH privilege separation directory
RUN mkdir /var/run/sshd

RUN apt-get install -y xorg xinit 

RUN curl -s https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz | tar -v -C /usr/local/ -xz

ENV PATH  /go/bin:/usr/local/go/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
ENV GOPATH  /go
ENV GOROOT  /usr/local/go

RUN go get github.com/robfig/revel
RUN go get github.com/robfig/revel/revel
RUN go get github.com/gocql/gocql
RUN go get github.com/codegangsta/martini

# Install LiteIDE
RUN curl -L -s http://downloads.sourceforge.net/project/liteide/X22/liteidex22.linux-64.tar.bz2 | tar -v -C /usr/local/ -xj

RUN apt-get install -y sakura gedit
RUN apt-get install -y gdb cgdb

# Add the user that will run the browser
RUN adduser --disabled-password --gecos "kevin" --uid 5001 kevin 

# Add SSH public key for kevin 
RUN mkdir /home/kevin/.ssh
ADD id_rsa.pub /home/kevin/.ssh/authorized_keys
RUN chown -R kevin:kevin /home/kevin/.ssh

# Add go binaries to path
RUN echo export PATH=$PATH:/usr/local/go/bin >> /home/kevin/.bashrc
#ENV PATH /usr/local/go/bin:$PATH

#EXPOSE 9000
#EXPOSE 6060

# Start SSH so we are ready to make a tunnel
#ENTRYPOINT ["/usr/sbin/sshd",  "-D"]

# Expose SSH port
EXPOSE 22
CMD /usr/sbin/sshd -D


#CMD godoc -http=":6060"

