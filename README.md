# jenkins-master

Jenkins docker image with Python 2.7, Python 3.5/pip3, Nodejs 6.9.0, Java 8, Docker 1.12.2

## Run

```
docker pull srvz/jenkins-master

docker run -d --name jenkins-master -p 8080:8080 -p 50000:50000 \
    -v {your/path}:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    srvz/jenkins-master
```