IMAGENAME?=jtilander/dev-debug
TAG?=test
DEV_TEST?=42
DEV_USER?=root
TERM?=xterm
DOCKER=docker
VOLUMES=-v $(PWD)/test:/home/jenkins
ENVIRONMENT=-e TERM=$(TERM)
PORTS=-p 9000:9000 -p 3000:3000 -p 4200:4200

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: image push clean run debug

image:
	$(DOCKER) build -t $(IMAGENAME):$(TAG) .
	$(DOCKER) images $(IMAGENAME):$(TAG)

push: image
	$(DOCKER) push $(IMAGENAME):$(TAG)

clean:
	$(DOCKER) rmi `docker images -q $(IMAGENAME):$(TAG)`
	$(DOCKER) run --rm -v `pwd`/test:/mnt alpine:3.5 /bin/sh -c "rm -rf /mnt"

run:
	$(DOCKER) run --rm $(VOLUMES) $(ENVIRONMENT) $(PORTS) -it $(IMAGENAME):$(TAG) $(RUN_ARGS)

debug:
	$(DOCKER) run --rm $(VOLUMES) $(ENVIRONMENT) $(PORTS) -it $(IMAGENAME):$(TAG) bash
