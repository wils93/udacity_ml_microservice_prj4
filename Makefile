## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install-hadolint:
	sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64
	sudo chmod +x /bin/hadolint
	which hadolint
	
install-k8s:
	cd /tmp && curl -LO "https://dl.k8s.io/release/$(shell curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
	cd /tmp && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	cd /tmp && chmod +x kubectl
	mkdir -p ~/.local/bin/kubectl
	cd /tmp && mv ./kubectl ~/.local/bin/kubectl

install-minikube:
	cd /tmp && curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
	sudo install /tmp/minikube-linux-amd64 /usr/local/bin/minikube
	which minikube

install-circleci:
	curl -fLSs https://raw.githubusercontent.com/CircleCI-Public/circleci-cli/master/install.sh | sudo bash
	which circleci

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203 app.py

all: install lint test
