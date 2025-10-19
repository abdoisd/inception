#!/bin/sh

if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then

        cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
        mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

        adduser $FTP_USER --disabled-password
	echo "$FTP_USER:$(cat /run/secrets/ftp_user_pass)" | chpasswd &> null
        chown -R $FTP_USER /var/www/html

fi

echo "FTP started on :21"

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
