## Queries used to Answer the question in module 3.

````sql
SELECT count(*) FROM `dzc-2025.Test.ny_taxi` ;

SELECT DISTINCT `VendorID` FROM `dzc-2025.Test.ny_taxi` 
Where tpep_dropoff_datetime > "2024-03-01" and tpep_dropoff_datetime <= "2024-03-15";


CREATE OR REPLACE TABLE dzc-2025.Test.ny_taxi_partitioned
PARTITION BY DATE(tpep_dropoff_datetime) 
CLUSTER BY VendorID AS
SELECT * FROM `dzc-2025.Test.ny_taxi` ;

SELECT DISTINCT `VendorID` FROM `dzc-2025.Test.ny_taxi_partitioned` 
Where tpep_dropoff_datetime >= "2024-03-01" and tpep_dropoff_datetime <= "2024-03-15"
````