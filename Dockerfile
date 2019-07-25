# start an official image
FROM python:3.7-stretch

# arbitrary location choice: you can change the directory
RUN mkdir -p /opt/services/app/src
WORKDIR /opt/services/app/src

# install our dependencies
COPY ./requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

CMD ["gunicorn", "--bind", ":8000", "djangoproj.wsgi:application"]
