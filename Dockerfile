FROM ubuntu:16.04

# Install python and pip
RUN apt-get update \
        && apt-get install -y python3-pip python3-mapnik \
        && rm -rf /var/lib/apt/lists/*
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Run the image as a non-root user
RUN adduser tilestache
USER tilestache

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:$PORT "TileStache:WSGITileServer('tilestache.cfg')"
