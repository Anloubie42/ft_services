no_mode_selected()
{
	echo "No mode selected, please relaunch scirpt with one of these modes :"
	echo "- \033[32mStart\033[0m : Start the VM"
	echo "- \033[32mServices\033[0m : restart all services"
}

start_mode_selected()
{
	echo "\033[31mVirtual Machine Starting\033[0m"
	minikube start --driver=docker > /dev/null
	minikube addons enable metallb > /dev/null
	build
	kubectl apply -k srcs/kustomisation
	minikube dashboard & > /dev/null
	# minikube config set vm-driver virtualbox
	# minikube start
}

stop_mode_selected()
{
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
		kubectl delete -f ./srcs/kustomization/nginx-deployment.yaml > /dev/null
	fi
}

build()
{
	eval $(minikube docker-env) > /dev/null
	docker build -t docker-nginx ./srcs/nginx > /dev/null
}

update()
{
	delete $2
	build
	kubectl apply -k srcs/kustomization
}

clear
if [ -z "$1" ]
then
	no_mode_selected
elif  [ "$1" = "start" ]
then
	start_mode_selected
elif [ "$1" = "services" ]
then
	echo "Working on this part"
	# echo "\033[31mDeleting all configuration...\033[0m"
	# kubectl delete all --all > /dev/null
	# echo "\033[31mBuilding New Image...\033[0m"
	# docker build -t docker-nginx ./srcs/nginx > /dev/null
	# echo "\033[31mCreating Services And Deployments...\033[0m"
	# kubectl apply -f srcs/nginx-service/nginx-service.yaml > /dev/null
	# kubectl apply -f srcs/nginx/srcs/nginx-deployment.yaml > /dev/null
	# kubectl apply -f srcs/ingress-test/ingress-service.yaml > /dev/null
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
