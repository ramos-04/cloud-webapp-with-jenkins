
# configure the base OS image
FROM ubuntu:18.04

# set the working directory
WORKDIR app

# here we create a new user. Please note how the commands are using &&. This helps with caching
RUN useradd -m -r nonroot-user && \
    chown nonroot-user /app

# requirements.txt contains the list of the dependant libraries along with the correct versions
COPY requirements.txt ./

# install the required softwares. Use only one RUN instruction to run as many commands as possible in order to reduce the docker image size. Each docker instruction when executed adds an intermediate layer
RUN apt-get update \
    && apt-get -y install python3-pip \
    && pip3 install -r requirements.txt

# expose the port on which Django server will spin up
EXPOSE 8080

# copy the Django source code in the docker image
# This instruction is intentionally used at the end in order to reduce the build time and save some disk space. This is the instruction which is most likely to insert changes in the docker image. If it is used before the installation of softwares, then everytime there is a change in the source code, all the subsequent docker layers are rebuilt. This would escalate the build time as well as increase the disk space
COPY . .

# make the non-root user active
USER nonroot-user

# run the server
CMD ["/app/django_project/start-server.sh"]






