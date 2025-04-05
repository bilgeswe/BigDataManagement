IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'gold_datapipelineaccount_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [gold_datapipelineaccount_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://gold@datapipelineaccount.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.[table12] (
	[primary_country] nvarchar(4000),
	[total_count] bigint,
	[total_duration] bigint,
	[modern_count] bigint,
	[classic_count] bigint,
	[modern_duration] bigint,
	[classic_duration] int,
	[modern_percentagecount] int,
	[classic_percentagecount] int,
	[modern_percentageduration] int,
	[classic_percentageduration] int
	)
	WITH (
	LOCATION = 'gold_parquet.parquet',
	DATA_SOURCE = [gold_datapipelineaccount_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

CREATE VIEW GoldLayerForML AS
SELECT 
    primary_country,
    release_year,
    total_duration,
    modern_count,
    classic_count
FROM dbo.[table12];
GO