1. Initialize tile database

    psql -c 'CREATE EXTENSION postgis; CREATE EXTENSION hstore;'

2. Load data

    osm2pgsql --hstore rhode-island-latest.osm.pbf

3. Generate Mapnik style

    carto openstreetmap-carto/project.mml > webapp/style.xml

4. Build image

    docker build -t map .
    heroku container:push web

5. Run image

    docker run -e PORT=5000 -p 5000:5000 -it map
    heroku container:release web

## Running on macOS

1. Install Mapnik, Python3 and the Python bindings for boost

    brew install mapnik python3 boost-python3

2. Set `BOOT_PYTHON_LIB`

The boost-python3 libraries will get linked into /usr/local/lib.  For example, you may have:

```
/usr/local/lib/libboost_python37.a
/usr/local/lib/libboost_python37.dylib
/usr/local/lib/libboost_python37-mt.a
/usr/local/lib/libboost_python37-mt.dylib
```
Set the `BOOST_PYTHON_LIB` variable accordingly.  For example, for libboost_python37, it should be:

    export BOOST_PYTHON_LIB=boost_python37

3. Install Python bindings for Mapnik

Make sure you are on the `v3.0.x` branch.

    cd python-mapnik
    git checkout v3.0.x
    python setup.py install
