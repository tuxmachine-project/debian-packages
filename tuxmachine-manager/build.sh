#!/bin/bash

# If a build already exists, replace it

if [ -d manager/desktop-app/dist ]
then
	rm -rf manager/desktop-app/dist
fi

if [ -d package ]
then
	rm -rf package
fi

# Compile the app

cd manager;./build.sh;cd ..

# if the output directory doesn't exist, create it.

if [ ! -d ../packages ]
then
	mkdir ../packages
fi

# Create package directory using config directory

cp -r config package

# Create directories

mkdir -p package/usr/bin
mkdir -p package/usr/share

# Copy the compiled app to the package folder & create a symlink to it

cp -r manager/desktop-app/dist/tuxmachine-manager-linux-x64 package/usr/share/tuxmachine-manager
ln -s /usr/share/tuxmachine-manager/tuxmachine-manager package/usr/bin/tuxmachine-manager

# Finally, create a .deb file

dpkg-deb --build package ../packages/tuxmachine-manager.deb