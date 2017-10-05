#!/usr/bin/env bash

trap 'exit' ERR
ROOT_DIR=$(pwd)
file="manage.py"

# Activate clean virtualenv.

VENV=venv-instaofficial

##use '.' before folder name makes it hidden
#VENV=.venv-instaofficial

if [ ! -d $VENV ]; then
virtualenv $VENV
fi
if [ -f $VENV/bin/activate ]; then
. $VENV/bin/activate
else
# On Windows, not bin for some reason.
. $VENV/Scripts/activate
fi

# Install python packages in virtualenv
pip install -r requirements.txt

#create django project
if [ -f "$file" ]
then
	echo "$file found."
else
	django-admin startproject mysite .
fi


# Run the python program
cd $ROOT_DIR

#DIRECTORY= blog
if [ ! -d "$ROOT_DIR/blog" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
   python manage.py startapp blog

fi

python manage.py migrate
python manage.py makemigrations blog

#<write the python command to execute>
#python instagramScrap.py -u umu,wara,rafi,taaasmina

python manage.py createsuperuser

python manage.py runserver
