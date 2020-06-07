
# configure the base OS image
FROM ubuntu:18.04

# install the required softwares
RUN apt-get update \
    && apt-get -y install python3-pip \
    && pip3 install Django

# set the working directory
WORKDIR app

# expose the port on which Django server will spin up
EXPOSE 8080

# copy the Django source code in the docker image
COPY . .

# run the server
CMD ["/app/django_project/start-server.sh"]






