no_mode_selected()
{
	echo "No mode selected, please relaunch scirpt with one of these modes :"
	echo "- \033[32mStart\033[0m : Start the VM"
	echo "- \033[32mStop\033[0m : Stop the VM"
	echo "- \033[32mUpdate <Service> \033[0m : Delete and restarts the service"
	echo "- \033[32mMinikube\033[0m : Installs Minikube"
}

set_ip()
{
	os="$(uname)"
	if [ "$os" == "Darwin" ]
	then
		ip="192.168.99.10"
	elif [ "$os" == "Linux" ]
	then
		ip="172.17.255.10"
	else
		echo "\033[31mThere has been a problem\033[0m"
		exit 1
	fi
	sed s/MINIKUBE_IP/$(minikube ip)/g < ./srcs/telegraf/srcs/telegraf.conf > ./srcs/telegraf/srcs/telegraf_ip.conf
	sed s/OS_IP/"$ip"/g < ./srcs/FTPS/srcs/vsftpd_generic.conf > ./srcs/FTPS/srcs/vsftpd.conf
	sed s/OS_IP/"$ip"/g < ./srcs/kustomization/metallb-configmap-generic.yaml > ./srcs/kustomization/metallb-configmap.yaml
	sed s/OS_IP/"$ip"/g < ./srcs/wordpress/srcs/wordpress_generic.sql > ./srcs/wordpress/srcs/wordpress.sql
}

minikube_install()
{
	os="$(uname)"
	echo "\033[31mInstalling Minikube...\033[0m"
	if [ "$os" == "Linux" ]
	then
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
		chmod +x minikube
		echo "\033[31mAdding Minikube to PATH...\033[0m"
		sudo mkdir -p /usr/local/bin
		sudo install minikube /usr/local/bin/
		echo "\033[31mAdding the user to Docker...\033[0m"
		sudo usermod -aG docker $USER && newgrp docker
	elif [ "$os" == "Darwin" ]
	then
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64
		chmod +x minikube
		echo "\033[31mAdding Minikube to PATH...\033[0m"
		mkdir -p /usr/local/bin
		mv Minikube /usr/local/bin
	fi
	echo "\033[31mMinikube ready to be used !\033[0m"
}

start_mode_selected()
{
	echo "\033[31mVirtual Machine Starting\033[0m"
	minikube config set WantUpdateNotification false
	os="$(uname)"
	if [ "$os" == "Linux" ]
	then
		sudo service docker start
		minikube config set driver docker
	elif [ "$os" == "Darwin" ]
	then
		minikube config set driver virtualbox
	else
		echo "\033[31mThere has been a problem\033[0m"
		exit 1
	fi
	minikube start
	minikube addons enable metallb
	minikube addons enable metrics-server
	set_ip
	build
	kubectl apply -k srcs/kustomization
	minikube dashboard &
}

stop_mode_selected()
{
	os="$(uname)"
	if [ "$os" == "Linux" ]
	then
		sudo service docker stop
	elif [ "$os" == "Darwin" ]
	then
		:
	else
		echo "\033[31mThere has been a problem\033[0m"
		exit 1
	fi
	echo "\033[31mStopping Virtual Machine...\033[0m"
	minikube stop
	echo "\033[31mDeleting Virtual Machine...\033[0m"
	minikube delete
	echo "\033[31mVirtual Machine Stopped And Deleted\033[0m"
}

delete()
{
	if [ "$1" = "nginx" ]
	then
		kubectl delete -f ./srcs/kustomization/nginx.yaml
	elif [ "$1" = "wordpress" ]
	then
		kubectl delete -f ./srcs/kustomization/wordpress.yaml
	elif [ "$1" = "mysql" ]
	then
		kubectl delete -f ./srcs/kustomization/mysql.yaml
	elif [ "$1" = "phpmyadmin" ]
	then
		kubectl delete -f ./srcs/kustomization/phpmyadmin.yaml
	elif [ "$1" = "ftps" ]
	then
		kubectl delete -f ./srcs/kustomization/ftps.yaml
	elif [ "$1" = "grafana" ]
	then
		kubectl delete -f ./srcs/kustomization/grafana.yaml
	elif [ "$1" = "influxdb" ]
	then
		kubectl delete -f ./srcs/kustomization/influxdb.yaml
	elif [ "$1" = "telegraf" ]
	then
		kubectl delete -f ./srcs/kustomization/telegraf.yaml
	fi
}

build()
{
	eval $(minikube docker-env)
	# eval $(minikube -p minikube docker-env)
	if [ -z "$1" ]
	then
		docker build -t docker-nginx ./srcs/nginx
		docker build -t docker-mysql ./srcs/MySQL
		docker build -t docker-wordpress ./srcs/wordpress
		docker build -t docker-phpmyadmin ./srcs/PhpMyAdmin
		docker build -t docker-ftps ./srcs/FTPS
		docker build -t docker-grafana ./srcs/grafana
		docker build -t docker-influxdb ./srcs/InfluxDB
		docker build -t docker-telegraf ./srcs/telegraf
	elif [ "$1" = "nginx" ]
	then
		docker build -t docker-nginx ./srcs/nginx
	elif [ "$1" = "wordpress" ]
	then
		docker build -t docker-wordpress ./srcs/wordpress
	elif [ "$1" = "mysql" ]
	then
		docker build -t docker-mysql ./srcs/MySQL
	elif [ "$1" = "phpmyadmin" ]
	then
		docker build -t docker-phpmyadmin ./srcs/PhpMyAdmin
	elif [ "$1" = "ftps" ]
	then
		docker build -t docker-ftps ./srcs/FTPS
	elif [ "$1" = "grafana" ]
	then
		docker build -t docker-grafana ./srcs/grafana
	elif [ "$1" = "influxdb" ]
	then
		docker build -t docker-influxdb ./srcs/InfluxDB
	elif [ "$1" = "telegraf" ]
	then
		docker build -t docker-telegraf ./srcs/telegraf
	fi
}

update()
{
	delete $2
	build $2
	kubectl apply -k srcs/kustomization
}

clear
if [ -z "$1" ]
then
	no_mode_selected
elif [ "$1" = "start" ]
then
	start_mode_selected
elif [ "$1" = "minikube" ]
then
	minikube_install
elif [ "$1" = "stop" ]
then
	stop_mode_selected
elif [ "$1" = "restart" ]
then
	stop_mode_selected
	start_mode_selected
elif [ "$1" = "update" ]
then
	update $1 $2
fi
