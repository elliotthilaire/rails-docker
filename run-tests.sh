apt-get update && apt-get install -y locales \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && rm -rf /var/lib/apt/lists/*

# ENV LANG en_US.UTF-8
echo LANG=en_US.UTF-8 > /etc/environment
apt-get update && apt-get install -y postgresql

sed -i -e 's/md5/trust/g' $(find / -name 'pg_hba.conf')
sed -i -e 's/peer/trust/g' $(find / -name 'pg_hba.conf')

service postgresql start

export PGUSER=postgres

rake test
