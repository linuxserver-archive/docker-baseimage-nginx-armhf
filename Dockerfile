FROM lsiobase/alpine.armhf:3.7

# install packages
RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache \
	apache2-utils \
	git \
	libressl2.6-libssl \
	logrotate \
	nano \
	nginx \
	openssl \
	php7 \
	php7-fileinfo \
	php7-fpm \
	php7-json \
	php7-mbstring \
	php7-openssl \
	php7-session \
	php7-simplexml \
	php7-xml \
	php7-xmlwriter \
	php7-zlib && \
 echo "**** configure nginx ****" && \
 echo 'fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;' >> \
	/etc/nginx/fastcgi_params && \
 rm -f /etc/nginx/conf.d/default.conf && \
 echo "**** fix logrotate ****" && \
 sed -i "s#/var/log/messages {}.*# #g" /etc/logrotate.conf

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80 443
VOLUME /config
