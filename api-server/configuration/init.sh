#!/bin/bash

set -e

EXIT_FAILURE=1
EXIT_SUCCESS=0

virtual_env="${APPLICATION_IMAGES_VIRTUAL_ENV:-.venv}"

pip3 install virtualenv
virtualenv -p python3 $virtual_env
source $virtual_env/bin/activate
pip install --upgrade pip
pip install -r requirements.txt || echo 'No requirements found.'

exit $EXIT_SUCCESS
