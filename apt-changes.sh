#!/bin/bash
# Output currently installed version of a package and recent changelogs.
# Pass a single package name or with no arguments to interactively enter package names.

function listchange {
	dpkg-query --list $1|grep -i $1
	echo
	# Condense apt-get output by squelching empty lines and signatures.
	apt-get changelog $1|grep -vP "(^$|^ --|^Get)"|head -n 15
}
if [ -z $1 ]; then
	while [ true ]; do
		read -p "Package string> " package
		if [ -z "$package" ]; then exit;fi
		if [ "$package" == "x" ]; then exit; fi
		listchange "$package"
	done
fi
listchange $1
