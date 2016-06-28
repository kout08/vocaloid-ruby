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
		echo "$1 is already exist"
	else
		echo "$1 is not exist. Start install."
		gem install $1
	fi
}

apt_install ruby
gem_install wav-file
gem_install sinatra
gem_install sinatra-contrib
