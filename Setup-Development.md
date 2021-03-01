# Create AgiPrx test container

## Setup LXD environment via snap

	apt install snapd
	snap install lxd
	bash; lxd init

Follow setup dialog.

## Launch test container as LXC container

	lxc launch images:debian/buster agiprxtest
	lxc bash agiprxtest
	$ apt-get install ssh python3 gpg
	$ mkdir /root/.ssh
	$ chmod 700 /root/.ssh
	$ exit
	lxc file push .ssh/id_rsa.pub agiprxtest/root/.ssh/authorized_keys
	lxc bash agiprxtest
	$ chown -R root.root /root/.ssh
	lxc ls
	# --> add IP to /etc/hosts

## Setup and deploy AgiPrx in test container

Continue with [AgiPrx Setup](Setup-Production.md) for configuration.

# Optional: Create minified JRE by jlink

	PROJECTBASE=/somepath1/agiprx-setup
	JDKBASE=/somepath2/jdk11openj9
	TMPDIR=/tmp
	rm -rf $TMPDIR/agiprxjre
	$JDKBASE/bin/jlink --vm server --add-modules java.base,java.logging,java.naming,java.sql,java.desktop,jdk.crypto.ec,jdk.jdwp.agent --output $TMPDIR/agiprxjre --no-header-files --no-man-pages --compress 2
	tar cfz $PROJECTBASE/ansible/roles/java11/files/agiprxjre.tgz -C $TMPDIR agiprxjre
	rm -rf $TMPDIR/agiprxjre
