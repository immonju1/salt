# setup salt master
# wget https://raw.githubusercontent.com/immonju1/salt/master/master.sh

setxkbmap fi
apt-get update -qq >> /dev/null
apt-get install git salt-master -y -qq >> /dev/null

# Create directories
if [ ! -d "/srv/" ]; then
mkdir /srv/
fi

cd /srv

git clone https://github.com/immonju1/salt.git

mkdir /srv/pillar

cp -R /srv/salt/srvpillar/* /srv/pillar



