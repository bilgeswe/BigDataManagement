CREATE DATABASE DataAnalytics6;
GO
USE GoldAnalytics;
GO

CREATE EXTERNAL DATA SOURCE DataLakeDataSource6
WITH (
    LOCATION = 'https://datapipelineaccount.dfs.core.windows.net'
);
CREATE EXTERNAL FILE FORMAT ParquetFormat6
WITH (
    FORMAT_TYPE = PARQUET
);
CREATE EXTERNAL TABLE netflix_data6 (
    primary_country NVARCHAR(100),
    total_count INT,
    total_duration BIGINT,
    modern_count INT,
    classic_count INT
)
WITH (
    LOCATION = '/gold_parquet.parquet',
    DATA_SOURCE = DataLakeDataSource6,
    FILE_FORMAT = ParquetFormat6
);