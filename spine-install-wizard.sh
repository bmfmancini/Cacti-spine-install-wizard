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




echo " this script requires git and unzip"
apt-get install unzip git -y


echo " 
This script will download and compile/install the SPINE poller used for Larger Cacti installations
the script will download all of the neccessary files and libraries needed to compile spine
"


##Download packages needed for spine
apt-get  install -y build-essential dos2unix dh-autoreconf libtool  help2man libssl-dev libmysql++-dev  librrds-perl libsnmp-dev 


echo " Which version of spine would you like to use ? Hit enter for the latest or enter the release vesrion i.e 1.2.3 Usually should Match your installed version of Cacti"
read version

if [ $version == "" ]
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



echo "Spine has been compiled and installed you will now need to configure your DB credentials to /usr/local/spine/etc/spine.conf"


