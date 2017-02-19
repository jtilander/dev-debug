IMAGENAME?=jtilander/dev-debug
TAG?=test
DEV_TEST?=42
DEV_USER?=root

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: image push clean run debug

image:
	docker build -t $(IMAGENAME):$(TAG) .
	docker images $(IMAGENAME):$(TAG)

push: image
	docker push $(IMAGENAME):$(TAG)

clean:
	docker rmi `docker images -q $(IMAGENAME):$(TAG)`

run:
	docker run --rm -e DEV_TEST=$(DEV_TEST) -e DEV_USER=$(DEV_USER) -it $(IMAGENAME):$(TAG) make $(RUN_ARGS)

debug:
	docker run --rm -e DEV_TEST=$(DEV_TEST) -e DEV_USER=$(DEV_USER) -it $(IMAGENAME):$(TAG) bash
