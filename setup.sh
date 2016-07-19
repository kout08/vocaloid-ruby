apt_install(){
	pkg=`dpkg -l | grep $1`
	if [ "$pkg" != "" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install."
		sudo apt-get install -y $1
	fi
}

gem_install(){
	gls=`gem list | grep $1`
	if [ "$gls" != "" ]; then
		echo "$1 is already exist."
	else
		echo "$1 is not exist. Start install."
		gem install $1
	fi
}

gem_uninstall(){
	gls=`gem list | grep $1`
	if [ "$gls" != "" ]; then
		echo "$1 is exist. Start uninstall."
		gem uninstall $1
	else
		echo "$1 is not exist."
	fi
}

gem_install_nodoc(){
	gls=`gem list | grep $1`
	if [ "$gls" != "" ]; then
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install."
		gem install $1 --no-rdoc --no-ri
	fi
}

apt_install ruby
gem_install wav-file
gem_install_nodoc sinatra
gem_install_nodoc sinatra-contrib
apt_install libsox-fmt-all
apt_install sox
apt_install libchromaprint-dev
gem_install ruby-sox
