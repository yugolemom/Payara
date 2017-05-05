FROM mcpayment/ubuntu-java8:1604

MAINTAINER Hugo C. Lima <yugolemom@gmail.com>

EXPOSE 4848 8009 8080 8181

ENV ADMIN_USER admin
ENV ADMIN_PASSWORD admin 
ENV PAYARA_PKG https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/Payara+4.1.1.171.0.1/payara-web-4.1.1.171.0.1.zip
ENV PAYARA_VERSION 171
ENV PKG_FILE_NAME payara-web-$PAYARA_VERSION.zip
ENV PAYARA_PATH /opt/payara41

# INSTALL PAYARA V 171

RUN apt-get install unzip wget

RUN mkdir -p $PAYARA_PATH && \
	wget --quiet -O /opt/$PKG_FILE_NAME $PAYARA_PKG && \
	unzip -qq /opt/$PKG_FILE_NAME -d $PAYARA_PATH && \
	mkdir -p $PAYARA_PATH/deployments

WORKDIR $PAYARA_PATH

CMD ["/bin/asadmin"]["start-domain"]
