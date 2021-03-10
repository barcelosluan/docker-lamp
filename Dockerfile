FROM ubuntu:18.04
MAINTAINER Luan F Barcelos <barcelosluan.dev@gmail.com>
LABEL Description="LAMP stack, based on Ubuntu 18.04 and PHP 7.3. Includes .htaccess support and popular PHP7.3 features. Forked from fauria/lamp" \
	License="Apache License 2.0" \
	Usage="docker run -d -p [HOST WWW PORT NUMBER]:80 -p [HOST DB PORT NUMBER]:3306 -v [HOST WWW DOCUMENT ROOT]:/var/www/html -v [HOST DB DOCUMENT ROOT]:/var/lib/mysql barcelosluan/lamp" \
	Version="1.0"


ENV LOG_STDOUT=**Boolean** \
    LOG_STDERR=**Boolean** \
    LOG_LEVEL=warn \
    ALLOW_OVERRIDE=All \
    TERM=dumb \
    TZ=America/Sao_Paulo

ARG DEBIAN_FRONTEND=noninteractive

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -qy --no-install-recommends \
        apache2 \
        curl \
        mariadb-server \
        mariadb-client \
        mariadb-common \
        software-properties-common \
        unzip \
        vim \
        zip \
    && add-apt-repository ppa:ondrej/php \
    && add-apt-repository ppa:ondrej/apache2 \
    && apt-get install -qy --no-install-recommends \
	php7.3 \
	php7.3-common \
	php7.3-curl \
	php7.3-dev \
	php7.3-enchant \
	php7.3-fpm \
	php7.3-gd \
	php7.3-gmp \
	php7.3-imap \
	php7.3-interbase \
	php7.3-intl \
	php7.3-json \
	php7.3-ldap \
	php7.3-mbstring \
	php7.3-mcrypt \
	php7.3-mysql \
	php7.3-odbc \
	php7.3-opcache \
	php7.3-pgsql \
	php7.3-phpdbg \
	php7.3-pspell \
	php7.3-readline \
	php7.3-recode \
	php7.3-snmp \
	php7.3-sqlite3 \
	php7.3-sybase \
	php7.3-tidy \
	php7.3-xmlrpc \
	php7.3-xsl \
	php7.3-zip \
        libapache2-mod-php7.3

COPY index.php /var/www/html/
COPY run-lamp.sh /usr/sbin/

RUN a2enmod rewrite
RUN chmod +x /usr/sbin/run-lamp.sh
RUN chown -R www-data:www-data /var/www/html

VOLUME /var/www/html
VOLUME /var/log/httpd
VOLUME /var/lib/mysql
VOLUME /var/log/mysql
VOLUME /etc/apache2

EXPOSE 80
EXPOSE 3306

CMD ["/usr/sbin/run-lamp.sh"]
