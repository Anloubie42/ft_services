no_mode_selected()
{
	echo "No mode selected, please relaunch scirpt with one of these modes :"
	echo "- \033[32mStart\033[0m : Start the VM"
	echo "- \033[32mStop\033[0m : Stop the VM"
	echo "- \033[32mUpdate <Service> \033[0m : Delete and restarts the service"
	echo "- \033[32mMinikube\033[0m : Installs Minikube"
}

minikube_install()
{
	echo "\033[31mInstalling Minikube...\033[0m"
	curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && \
	chmod +x minikube && \
	echo "\033[31mAdding Minikube to PATH...\033[0m"
	sudo mkdir -p /usr/local/bin && \
	sudo install minikube /usr/local/bin/
	echo "\033[31mAdding the user to Docker...\033[0m"
	sudo usermod -aG docker $USER && newgrp docker
	echo "\033[31mMinikube ready to be used !\033[0m"
}

start_mode_selected()
{
	echo "\033[31mVirtual Machine Starting\033[0m"
	# sudo service docker start
	minikube config set WantUpdateNotification false
	# minikube config set driver docker
	minikube config set driver virtualbox
	minikube start
	minikube addons enable metallb
	minikube addons enable metrics-server
	build
	kubectl apply -k srcs/kustomization
	sed s/MINIKUBE_IP/$(minikube ip)/g < ./srcs/telegraf/srcs/telegraf.conf > ./srcs/telegraf/srcs/telegraf_ip.conf
	minikube dashboard &
}

stop_mode_selected()
{
	# sudo service docker stop
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
elif  [ "$1" = "start" ]
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
