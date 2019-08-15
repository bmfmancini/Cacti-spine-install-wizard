#!/bin/bash

##Author Sean Mancini
#www.seanmancini.com

##Purpose this script will facilitate the installation of Cacti along with all supporting binaries 
#this script will also ensure that proper configurations are put in place to get up and running with cacti

##Dont forget to checkout cacti @ www.cacti.net

#    This program is free software: you can redistribute it and/or modify#
#    it under the terms of the GNU General Public License as published by#
#    the Free Software Foundation, either version 3 of the License, or#
#    (at your option) any later version.#
#    This program is distributed in the hope that it will be useful,#
#    but WITHOUT ANY WARRANTY; without even the implied warranty of#
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the#
#    GNU General Public License for more details.#
#    You should have received a copy of the GNU General Public License#
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.#




echo " this script requires unzip"
apt-get install unzip  -y


echo " 
This script will download and compile/install the SPINE poller used for Larger Cacti installations
the script will download all of the neccessary files and libraries needed to compile spine
"
sleep 2


##Download packages needed for spine
apt-get  install -y build-essential dos2unix dh-autoreconf libtool  help2man libssl-dev     librrds-perl libsnmp-dev 
apt-get install -y libmysql++-dev ##For debian 9 and below
apt-get install -y default-libmysqlclient-dev ###For debian 10+

echo " Which version of spine would you like to use ? Hit enter for the latest or enter the release vesrion i.e 1.2.3 Usually should Match your installed version of Cacti"
read version

if [$version = ""]
then

echo "downloadinglatest version of spine  and compling "
git clone https://github.com/Cacti/spine.git
cd spine
./bootstrap
./configure
make
make install
chown root:root /usr/local/spine/bin/spine
chmod u+s /usr/local/spine/bin/spine

else

wget https://github.com/Cacti/spine/archive/release/$version.zip
unzip $version.zip
cd spine-release-$version
./bootstrap
./configure
make
make install
chown root:root /usr/local/spine/bin/spine
chmod u+s /usr/local/spine/bin/spine

fi

cp /usr/local/spine/etc/spine.conf.dist  /usr/local/spine/etc/spine.conf



echo "Spine has been compiled and installed you will now need to configure your DB credentials to /usr/local/spine/etc/spine.conf"

echo "Would you like to configure you spine.conf file? y or n"
read answer
if [ $answer == "y" ]
then
echo "Enter database user"
read user
echo "enter database password"
read password
echo "enter database name"
read databasename

sed -i -e 's@^DB_Host.*@DB_Host  127.0.0.1@g' /usr/local/spine/etc/spine.conf
sed -i -e 's@^DB_User.*@DB_User  '$user'@g' /usr/local/spine/etc/spine.conf
sed -i -e 's@^DB_Pass.*@DB_Pass  '$password'@g' /usr/local/spine/etc/spine.conf
sed -i -e 's@^DB_Database.*@DB_Database  '$databasename'@g' /usr/local/spine/etc/spine.conf

else


echo "spine install completed"

fi
