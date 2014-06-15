echo "update and install basics software"
apt-get update
apt-get install vim curl python g++ make checkinstall build-essential python-software-properties

echo "Add customs sources list"
echo "\n# nginx repositories\n" >> /etc/apt/sources.list
echo "deb http://nginx.org/packages/debian/ wheezy nginx\n" >> /etc/apt/sources.list
echo "deb-src http://nginx.org/packages/debian/ wheezy nginx\n" >> /etc/apt/sources.list

# varnish repositories
curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add -
echo "\n# Varnish repositories\n" >> /etc/apt/sources.list
echo "deb http://repo.varnish-cache.org/ubuntu/ lucid varnish-3.0" >> /etc/apt/sources.list

# docker repositories
echo deb http://get.docker.io/ubuntu docker main | tee /etc/apt/sources.list.d/docker.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9

# mariadb repositories
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
add-apt-repository 'deb http://ftp.igh.cnrs.fr/pub/mariadb/repo/10.0/debian wheezy main'

echo "install varnish nginx docker mariadb"
apt-get update
apt-get install varnish nginx lxc-docker mariadb-server mariadb-client

echo "install nodejs & npm"
mkdir ~/node_js_src && cd $_
wget -N http://nodejs.org/dist/node-latest.tar.gz
tar xzvf node-latest.tar.gz && cd node-v*
./configure
checkinstall
(change the version v0.* to 0.*)
sudo dpkg -i node_*

curl https://www.npmjs.org/install.sh | sudo sh

ln -s /usr/local/bin/node /usr/sbin/node

echo "install node global libraries"
npm install -g vtop grunt-cli

echo "Install php as cli"
apt-get install php5-cli php5-curl php5-mysql