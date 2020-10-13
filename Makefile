include VERSION

SERV_NAME = tree-diagram
APP_NAME = 233825477968.dkr.ecr.ap-northeast-1.amazonaws.com/${SERV_NAME}:${Version}-${Release}
TARGET = $1

#DOCKERFILE_DEV = Dockerfile_dev
DOCKERFILE_DEV = Dockerfile
DOCKERFILE_PUB = Dockerfile_pub

all: check

check:
ifeq ($(TARGET),)
	@echo Warning: where do you want to deploy\, d for development\, p for publishment? [d/p]
	@read line; \
	if [ $$line = "d" ] ; then \
        make dev ; \
    elif [ $$line = "p" ] ; then \
        make pub ; \
    else \
        echo aborting ; exit 1 ; \
    fi
endif

# development
dev: build_dev
# publishment
pub: build_pub

build_dev:
	@echo "Docker image build for service"
	cd docker/nodejs-tree && \
	cp -r ../../treejs  ./ && \
	docker build  -t ${APP_NAME} . --build-arg Version="${Version}" --build-arg Release="${Release}"  --file ./${DOCKERFILE_DEV}; \
	rm -rf ./treejs
	@echo "finish build."

build_pub:
	@echo "Docker image build for service"
	cd docker/nodejs-tree && \
	cp -r ../../treejs  ./ && \
	docker build  -t ${APP_NAME} . --build-arg Version="${Version}" --build-arg Release="${Release}"  --file ./${DOCKERFILE_PUB}; \
	rm -rf ./treejs
	@echo "finish build."

push:
	@echo "pushing image..."
	`aws ecr get-login --no-include-email --region ap-northeast-1`
	docker push ${APP_NAME}
	@echo "finish pushing image."


clean:
	@echo "clean Docker images"
	docker rmi ${APP_NAME}
	@echo "**************************************** done ! *************************************"


