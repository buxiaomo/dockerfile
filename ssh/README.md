# Docker SSHD

```
# build image
docker build -t sshd:latest .

# default root password is root
docker run -it --rm sshd:latest

# set root password is 123456
docker run -it -e ROOT_PASSWORD=123456 --rm sshd:latest
```