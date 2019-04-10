FROM cloudwattfr/ntpserver

# RUN apt-get update && apt-get install -y ntp && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ntp.conf /etc/ntp.conf
# CMD ["/usr/sbin/ntpd", "-n"]

# EXPOSE 123