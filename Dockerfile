# start an official image
FROM python:3.7-stretch

ENV PYTHONBUFFERED 1

# Get microsoft packages to allow download and install of ODBC Driver 17
RUN apt-get update && apt-get -y install apt-transport-https
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Update and install Microsoft tools and Python to MSSQL driver connection
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17

## Enable sqlcmd command to container
#RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
#RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
#RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#RUN /bin/bash -c "source ~/.bashrc"
RUN apt-get install -y unixodbc-dev

# arbitrary location choice: you can change the directory
RUN mkdir -p /opt/services/app/src

ADD . /opt/services/app/src
WORKDIR /opt/services/app/src

# install our dependencies
COPY ./requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt

# Copy odbcinst.ini to /etc/
COPY ./config/odbc/odbcinst.ini /etc/odbcinst.ini

CMD ["sh", "-c", "python manage.py migrate && gunicorn --bind :8000 djangoproj.wsgi:application"]
