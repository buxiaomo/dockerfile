FROM python:2.7.14-alpine3.7
MAINTAINER "Xiao Mo" <root@xiaomo.red>

RUN pip install -i https://pypi.tuna.tsinghua.edu.cn/simple flask requests

ADD . /app

WORKDIR /app

ENV RegistryURL hub.xmitd.com

EXPOSE 5000

CMD ["python","DockerRegistryUI.py"]