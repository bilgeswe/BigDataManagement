# BigDataManagement
Building a Data Pipeline with Lakehouse Architecture on Microsoft Azure Platform


## INTRODUCTION
In today’s data-driven world, the ability to efficiently process, analyze, and derive
insights from large datasets is critical for organizations across various industries. This
project focuses on building an end-to-end data pipeline to analyze Netflix's content
dataset, leveraging Azure cloud services to implement a scalable and reliable solution.
The project follows a structured data pipeline model, transitioning data through ingestion,
processing, storage, and serving layers, to create actionable insights for business and
academic purposes. The goal is to identify trends in Netflix content production across
regions and categories, such as the proportion of modern vs. classic content and the
distribution of content duration and count by country. The pipeline design ensures
flexibility, automation, and adaptability to future data needs, adhering to best practices in
data engineering.
For the researcher, this study was eye opening as it was the first time for using many
tools at hand.

### Key Components
Azure Data Factory (ADF): Used for orchestrating and automating data ingestion and
transformation processes.
Azure Data Lake Storage Gen2: Serves as the storage layer, structured into Bronze,
Silver, and Gold layers for raw, processed, and analytics-ready data.
Azure Synapse Analytics: Enables querying, visualizing, and analyzing data using SQL
external tables.
External Tables: Facilitates the serving layer by providing seamless access to processed
data stored in the "Gold" layer.
Visualization Tools: SQL-based visualizations in Azure Synapse replace Power BI due
to subscription constraints.

### Keywords
Data Pipeline, Azure Cloud Services, Data Factory, Data Lake Storage, Synapse
Analytics, Content Analysis, Modern vs. Classic Content, Regional Content Trends,
Machine Learning Integration

https://www.kaggle.com/datasets/shivamb/netflix-shows
