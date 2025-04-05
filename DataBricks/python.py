storage_account_name = "<storage_account_name>"
storage_account_key = "<storage_account_key>"
raw_container = "<raw_container>"

spark.conf.set(f"fs.azure.account.key.{storage_account_name}.dfs.core.windows.net", storage_account_key)

raw_file_path = f"abfss://{raw_container}@{storage_account_name}.dfs.core.windows.net/netflix_titles.csv"

raw_data = spark.read.csv(raw_file_path, header=True, inferSchema=True)

raw_data.show(5)
