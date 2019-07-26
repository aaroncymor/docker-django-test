# start an official image
FROM python:3.7-stretch

# arbitrary location choice: you can change the directory
RUN mkdir -p /opt/services/app/src

ADD . /opt/services/app/src
WORKDIR /opt/services/app/src

# install our dependencies
COPY ./requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

CMD ["sh", "-c", "python manage.py makemigrations app && python manage.py migrate app && gunicorn --bind :8000 djangoproj.wsgi:application"]
