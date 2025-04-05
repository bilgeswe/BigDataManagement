source(output(
		show_id as string,
		type as string,
		title as string,
		director as string,
		cast as string,
		country as string,
		date_added as string,
		release_year as string,
		rating as string,
		duration as string,
		listed_in as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> BronzeDataSet
BronzeDataSet filter(!isNull(release_year) && !isNull(type) && !isNull(country) && !isNull(duration)) ~> CleanData
CleanData select(mapColumn(
		show_id,
		type,
		movie_title = title,
		country,
		release_year,
		duration
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> select1
select1 derive(release_category = iif(toInteger(release_year) >= 2000, 'Modern', 'Classic'),
		{standardized_duration(mins)} = iif(type == 'Movie',
    toInteger(substring(duration, 0, locate(' ', duration))),
    toInteger(substring(duration, 0, locate(' ', duration))) * 480
),
		is_last_10_years = iif(toInteger(release_year) >= 2014, true(), false()),
		primary_country = split(toString(country), ',')[1]) ~> derivedColumn1
derivedColumn1 aggregate(groupBy(type,
		release_category),
	total_duration = sum(toInteger({standardized_duration(mins)}))) ~> aggregate1
derivedColumn1 sink(allowSchemaDrift: true,
	validateSchema: false,
	partitionFileNames:['netflix_titles_enriched.csv'],
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	partitionBy('hash', 1)) ~> WriteToSilver