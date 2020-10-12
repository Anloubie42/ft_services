clear
if [ -z $1 ]
then
	echo "No mode selected, please relaunch scirpt with one of these modes :"
	echo "- \033[32mStart\033[0m : Start the VM"
	echo "- \033[32mServices\033[0m : restart all services"
elif  [ $1 == "start" ]
then
	echo "\033[31mVirtual Machine Starting\033[0m"
	minikube config set vm-driver virtualbox
	minikube start
	minikube dashboard &
	eval $(minikube docker-env)
	docker build -t docker-nginx ./srcs/nginx > /dev/null
	kubectl apply -f srcs/nginx-service/nginx-service.yaml > /dev/null
	kubectl apply -f srcs/nginx/srcs/nginx-deployment.yaml > /dev/null
	kubectl apply -f srcs/ingress-test/ingress-service.yaml > /dev/null
elif [ $1 == "services" ]
then
	echo "\033[31mDeleting all configuration...\033[0m"
	kubectl delete all --all > /dev/null
	echo "\033[31mBuilding New Image...\033[0m"
	docker build -t docker-nginx ./srcs/nginx > /dev/null
	echo "\033[31mCreating Services And Deployments...\033[0m"
	kubectl apply -f srcs/nginx-service/nginx-service.yaml > /dev/null
	kubectl apply -f srcs/nginx/srcs/nginx-deployment.yaml > /dev/null
	kubectl apply -f srcs/ingress-test/ingress-service.yaml > /dev/null
elif [ $1 == "stop" ]
then
	#echo "\033[31mStopping Virtual Machine...\033[0m"
	minikube stop
	#echo "\033[31mDeleting Virtual Machine...\033[0m"
	minikube delete
	#echo "\033[31mVirtual Machine Stopped And Deleted\033[0m"
fi
