# `make` is expected to be called from the directory that contains
# this Makefile

TAG ?= trolltunga
BUILDNR ?= 1
BRANCH ?= master

help:
	@echo "Available commands to 'make':"
	@echo "  set-buildnr  : set buildnr in all vantage6 packages"
	@echo "  uninstall    : uninstall all vantage6 packages"
	@echo "  install      : do a regular install of all vantage6 packages"
	@echo "  install-dev  : do an editable install of all vantage6 packages"
	@echo "  image 		  : build the node/server docker image"
	@echo "  docker-push  : push the node/server docker image"
	@echo "  rebuild      : rebuild all python packages"
	@echo "  publish-test : publish built python packages to test.pypi.org"
	@echo "  publish      : publish built python packages to pypi.org (BE CAREFUL!)"
	@echo "  clean        : clean all built packages"
	@echo "  checkout     : git checkout a BRANCH"
	@echo ""
	@echo "Using tag: ${TAG}"

checkout:
	cd vantage6-common && git checkout ${BRANCH}
	cd vantage6-client && git checkout ${BRANCH}
	cd vantage6 && git checkout ${BRANCH}
	cd vantage6-node && git checkout ${BRANCH}
	cd vantage6-server && git checkout ${BRANCH}

commit:
	cd vantage6-common && git commit -a -m "bumped version"
	cd vantage6-client && git commit -a -m "bumped version"
	cd vantage6 && git commit -a -m "bumped version"
	cd vantage6-node && git commit -a -m "bumped version"
	cd vantage6-server && git commit -a -m "bumped version"

git-push:
	cd vantage6-common && git push
	cd vantage6-client && git push
	cd vantage6 && git push
	cd vantage6-node && git push
	cd vantage6-server && git push

git-merge:
	cd vantage6-common && git merge ${BRANCH}
	cd vantage6-client && git merge ${BRANCH}
	cd vantage6 && git merge ${BRANCH}
	cd vantage6-node && git merge ${BRANCH}
	cd vantage6-server && git merge ${BRANCH}

git-tag:
	cd vantage6-common && git tag -a "${TAG}" -m "Release ${TAG}" && git push origin ${TAG}
	cd vantage6-client && git tag -a "${TAG}" -m "Release ${TAG}" && git push origin ${TAG}
	cd vantage6 && git tag -a "${TAG}" -m "Release ${TAG}" && git push origin ${TAG}
	cd vantage6-node && git tag -a "${TAG}" -m "Release ${TAG}" && git push origin ${TAG}
	cd vantage6-server && git tag -a "${TAG}" -m "Release ${TAG}" && git push origin ${TAG}

set-buildnr:
	find ./ -name __build__ -exec sh -c "echo ${BUILDNR} > {}" \;

uninstall:
	pip uninstall -y vantage6
	pip uninstall -y vantage6-client
	pip uninstall -y vantage6-common
	pip uninstall -y vantage6-node
	pip uninstall -y vantage6-server

install:
	cd vantage6-common && pip install .
	cd vantage6-client && pip install .
	cd vantage6 && pip install .
	cd vantage6-node && pip install .
	cd vantage6-server && pip install .

install-dev:
	cd vantage6-common && pip install -e .
	cd vantage6-client && pip install -e .
	cd vantage6 && pip install -e .
	cd vantage6-node && pip install -e .
	cd vantage6-server && pip install -e .

image:
	docker build -t harbor.vantage6.ai/infrastructure/node:${TAG} .
	docker tag harbor.vantage6.ai/infrastructure/node:${TAG} harbor.vantage6.ai/infrastructure/server:${TAG}

docker-push:
	docker push harbor.vantage6.ai/infrastructure/node:${TAG}
	docker push harbor.vantage6.ai/infrastructure/server:${TAG}

rebuild:
	cd vantage6-common && make rebuild
	cd vantage6-client && make rebuild
	cd vantage6 && make rebuild
	cd vantage6-node && make rebuild
	cd vantage6-server && make rebuild

publish-test:
	cd vantage6-common && make publish-test
	cd vantage6-client && make publish-test
	cd vantage6 && make publish-test
	cd vantage6-node && make publish-test
	cd vantage6-server && make publish-test

publish:
	cd vantage6-common && make publish
	cd vantage6-client && make publish
	cd vantage6 && make publish
	cd vantage6-node && make publish
	cd vantage6-server && make publish

clean:
	cd vantage6-common && make clean
	cd vantage6-client && make clean
	cd vantage6 && make clean
	cd vantage6-node && make clean
	cd vantage6-server && make clean
