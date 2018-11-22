# setup salt master
# wget https://raw.githubusercontent.com/immonju1/salt/master/master.sh
# chmod g+x master.sh
# sudo ./master.sh

setxkbmap fi
echo "Updating packages and install salt and git..."
apt-get update -qq >> /dev/null
apt-get install git salt-master -y -qq >> /dev/null

# Create directories
if [ ! -d "/srv/" ]; then
mkdir /srv/
fi
echo "Cloning Git..."
cd /srv

git clone https://github.com/immonju1/salt.git

mkdir /srv/pillar
echo "Copying pillars..."
cp -R /srv/salt/srvpillar/* /srv/pillar



