# jenkins-master

Jenkins docker image with Python 2.7.9/pip, Python 3.5.2/pip3, Nodejs 6.9.1, Java 8/maven 3.3.9, Docker 1.12.2, vim

## Run

```
docker pull srvz/jenkins-master

docker run -d --name jenkins-master -p 8080:8080 -p 50000:50000 \
    -v {your/path}:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    srvz/jenkins-master
```