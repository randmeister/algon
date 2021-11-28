

docker_build:
	docker build -t randmeister/algon:local docker

helm_upgrade_local:
	helm upgrade \
		--install \
		--namespace algon \
		--set image.tag=local \
		--set image.pullPolicy=Never \
		--set resources.requests.cpu=0.5 \
		--set resources.requests.memory=0.5 \
		--set resources.limits.cpu=0.5 \
		--set resources.limits.memory=1Gi \
		algon charts/algon

helm_upgrade:
	helm repo update
	helm upgrade \
		--install \
		--namespace algon \
		algon algon/algon

helm_delete:
	helm delete algon -n algon || true

algon_pod_delete:
	kubectl delete pod algon-0 --force=true || true

helm_rebuild_local: helm_delete algon_pod_delete
	kubectl delete namespace algon || true
	kubectl create namespace algon
	make helm_upgrade_local
	
minikube_docker_daemon:
	eval $(minikube docker-env)
