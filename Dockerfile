FROM ubuntu:16.04

# Install python and pip
RUN apt update && apt install -y python3-pip python3-mapnik
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies
RUN pip3 install --no-cache-dir -q -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Run the app.  CMD is required to run on Heroku
# $PORT is set by Heroku			
CMD gunicorn --bind 0.0.0.0:$PORT "TileStache:WSGITileServer('tilestache.cfg')"
