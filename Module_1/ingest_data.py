import pandas as pd
from sqlalchemy import create_engine
import argparse
import os

def main(params):
    engine = create_engine(f'postgresql://{params.username}:{params.password}@{params.host}:{params.port}/{params.db}')

    csv_name = 'output.csv'
    os.system(f'wget {params.url} -O {csv_name}')
    # os.system(f'gunzip {csv_name}.gz')
    
    df = pd.read_csv(csv_name)
    # df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    # df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)
    df = next(df_iter)

    # df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
    # df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

    df.head(0).to_sql(name=params.table_name, con=engine, if_exists='replace')

    df.to_sql(name=params.table_name, con=engine, if_exists='append')

    while True:
        df = next(df_iter)
        # df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        # df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)
        df.to_sql(name=params.table_name, con=engine, if_exists='append')
        print("Inserted another chunk..")

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("username")
    parser.add_argument("password")
    parser.add_argument("host")
    parser.add_argument("port")
    parser.add_argument("db")
    parser.add_argument("table_name")
    parser.add_argument("url")
    args = parser.parse_args()
    print(args)
    main(args)
