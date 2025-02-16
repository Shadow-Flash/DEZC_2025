import dlt
from dlt.sources.helpers.rest_client import RESTClient
from dlt.sources.helpers.rest_client.paginators import PageNumberPaginator
import requests

BASE_API_URL = "https://us-central1-dlthub-analytics.cloudfunctions.net/data_engineering_zoomcamp_api"

@dlt.resource(name="rides")
def ny_taxi():
    client = RESTClient(
        base_url="https://us-central1-dlthub-analytics.cloudfunctions.net",
        paginator=PageNumberPaginator(
            base_page=1,
            total_path=None
        )
    )

    for page in client.paginate("data_engineering_zoomcamp_api"):
        yield page

pipeline = dlt.pipeline(
    pipeline_name="ny_taxi_pipeline",
    destination="postgres",
    dataset_name="ny_taxi_data"
)

info = pipeline.run(ny_taxi)
# print(info)

# data = pipeline.dataset(dataset_type="default").rides.df()
# print(data)

with pipeline.sql_client() as client:
    res = client.execute_sql( 
            """
            SELECT AVG(EXTRACT(EPOCH FROM (trip_dropoff_date_time - trip_pickup_date_time)) / 60) AS avg_trip_duration
            FROM rides;
            """
        )
    # Prints column values of the first row
    print(res)