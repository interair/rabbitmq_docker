## Rabbitmq-cluster with enabled hipe_compile and erlang cookies


```
docker run -d --name rabbitmq \
	 -p 5672:5672 -p 15672:15672 -p 35197:35197 -p 4369:4369 -p 25672:25672 -l port=5672 \
	 -e constraint:node-type==~master \
	 -e HOSTNAME=rabbitmq.weave.local \
	 -e RABBITMQ_PASS="opentsp" \
	 -e RABBITMQ_USE_LONGNAME=true \
	 -l service-type=system \
	 -l application=rabbitmq \
	 --restart=always \
	 codeabovelab/rabbitmq
```

sh scale_rabbitmq.sh
```
NAME=(calc_name) example: rabbitmq-1

echo $NAME

docker run -d --name $NAME \
         -p 5672:5672 -p 15672:15672 -p 35197:35197 -p 4369:4369 -p 25672:25672 -l port=5672 \
         -e HOSTNAME=$NAME.weave.local \
         -e RABBITMQ_USE_LONGNAME=true \
         -e RABBITMQ_PASS="opentsp" \
         -e CLUSTER_WITH=rabbitmq.weave.local \
         -l service-type=system \
         -l application=rabbitmq \
          --restart=always \
         codeabovelab/rabbitmq
```
