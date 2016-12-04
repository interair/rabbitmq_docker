FROM debian:testing
MAINTAINER interair

	# install Erlang
	RUN apt-get update \
	&& apt-get install -y --no-install-recommends --allow-unauthenticated \
    apt-utils \
	erlang-asn1 \
	erlang-base-hipe \
	erlang-crypto \
	erlang-eldap \
	erlang-inets \
	erlang-mnesia \
	erlang-nox \
	erlang-os-mon \
	erlang-public-key \
	erlang-ssl \
	erlang-xmerl 

# install Rabbitmq	
RUN apt-get update && apt-get install -y --allow-unauthenticated rabbitmq-server pwgen && rabbitmq-plugins enable rabbitmq_management 

RUN echo "ERLANGCOOKIE" > /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie

# get logs to stdout (thanks @dumbbell for pushing this upstream! :D)
ENV RABBITMQ_LOGS=- RABBITMQ_SASL_LOGS=-

# Add scripts
ADD run.sh /run.sh
ADD set_rabbitmq_configuration.sh /set_rabbitmq_configuration.sh
RUN chmod 755 ./*.sh

EXPOSE 5672 15672 25672

CMD ["/run.sh"]
