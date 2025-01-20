docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v $(pwd)/ny_taxi_postgress_data:/var/lib/postgresql/data \
    -p 5431:5432 \
    postgres:13

pgcli -h localhost -p 5431 -u root -d ny_taxi

gunzip - to extract csv file from original file
less - to check the csv file content
wc -l - to count number of lines in the file -l is for lines wc is for word count
head -n it will give you the data from top to the specified line <integer >-

docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    dpage/pgadmin4

docker network create local-network

docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v $(pwd)/ny_taxi_postgress_data:/var/lib/postgresql/data \
    -p 5431:5432 \
    --network=local-network \
    --name=pg_database \
    postgres:13

docker run -it \
    -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
    -e PGADMIN_DEFAULT_PASSWORD="root" \
    -p 8080:80 \
    --network=local-network \
    --name=pg_admin \
    dpage/pgadmin4

/Library/Developer/CommandLineTools/usr/bin/python3 ingest_data.py \
    root \
    root \
    localhost \
    5431 \
    ny_taxi \
    taxi_zone_data \
    https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv

docker build -t test:ingest_datav1 .

docker run -it --network=local-network \
    test:ingest_datav1 \
    root \
    root \
    pg_database \
    5432 \
    ny_taxi \
    yellow_taxi_trips_data \
    https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-07.csv.gz
