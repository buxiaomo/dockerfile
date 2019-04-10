FROM ubuntu:16.04

COPY sources.list /etc/apt/sources.list

RUN apt-get update  \
    && echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
    && apt-get -y install locales-all fonts-wqy-microhei fonts-wqy-zenhei fontconfig libxt6 libxrender1 \
    && apt-get -y install libreoffice --no-install-recommends --no-install-suggests \
    && dpkg-reconfigure fontconfig && fc-cache -f -s -v && rm -rf /srv/* 

# soffice -headless  \
# -invisible -norestore \
# -nodefault -nolockcheck  \
# -nofirststartwizard -convert-to pdf:writer_pdf_Export \
# -outdir /word /word