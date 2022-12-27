FROM ubuntu:18.04
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y python3 python3-pip python3-dev

RUN python3 -m pip install --upgrade "pip~=21.0" "setuptools~=59.2"

RUN pip3 install \
    "python-lsp-server[all]" \
    "python-lsp-black" \
    "pylsp-mypy" \
    "pyls-isort"
