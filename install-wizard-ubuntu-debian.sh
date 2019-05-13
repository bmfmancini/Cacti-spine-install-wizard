



echo "will you be using the spine poller enter 1 for yes 2 for no"
read answer
if [ $answer == "1" ]
then
##Download packages needed for spine
apt-get  install -y build-essential dos2unix dh-autoreconf libtool  help2man libssl-dev libmysql++-dev  librrds-perl libsnmp-dev 
echo "downloading and compling spine"
git clone https://github.com/Cacti/spine.git
cd spine
./bootstrap
./configure
make
make install
chown root:root /usr/local/spine/bin/spine
chmod u+s /usr/local/spine/bin/spine
cd ..

