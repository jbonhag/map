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
