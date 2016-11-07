#!/bin/bash

# set exit on error
set -e

ver="0.5.1"
name="novnc"
release="4"


echo "final package"
echo ${name}-${ver}-${release}.noarch.rpm

# prepare the source
echo ''
echo '---- copy source code ----'
mkdir -p tmp/${name}-${ver}/
mkdir -p tmp/dist/
cp -r *.html favicon.ico karma.conf.js package.json crossdomain.xml images/ LICENSE.txt docs/ include/ README.md tests/ utils/ tmp/${name}-${ver}/
cp ${name}.spec tmp/
cd tmp

# prepare tar
echo ''
echo '---- create tar ball ----'
tar -cvf ${name}-${ver}.tar.gz ${name}-${ver}/

# build rpm
echo ''
echo '---- rpmbuild ----'
mv ${name}-${ver}.tar.gz ~/rpmbuild/SOURCES
mv ${name}.spec ~/rpmbuild/SPECS/
rpmbuild -bb ~/rpmbuild/SPECS/${name}.spec

mv ~/rpmbuild/RPMS/noarch/${name}-${ver}-${release}.*noarch.rpm dist


