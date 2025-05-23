source(output(
		show_id as string,
		type as string,
		movie_title as string,
		country as string,
		release_year as string,
		duration as string,
		release_category as string,
		{standardized_duration(mins)} as string,
		is_last_10_years as string,
		primary_country as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> silver
silver filter(toBoolean(is_last_10_years) == true()) ~> filter1
filter2 aggregate(groupBy(primary_country),
	total_count = count(primary_country),
		total_duration = sum(toInteger(standardized_duration_mins)),
		modern_count = countIf(release_category == 'Modern'),
		classic_count = countIf(release_category == 'Classic'),
		modern_duration = sumIf(release_category=='Modern', toInteger(standardized_duration_mins)),
		classic_duration = coalesce(toInteger(sumIf(release_category == 'Classic', toInteger(standardized_duration_mins))), 0)) ~> aggregate1
select1 filter(!isNull(standardized_duration_mins) && !isNull(primary_country)) ~> filter2
aggregate1 derive(modern_percentagecount = toInteger((modern_count / total_count) * 100),
		classic_percentagecount = toInteger(100 - ((modern_count / total_count) * 100)),
		modern_percentageduration = toInteger((modern_duration / total_duration) * 100),
		classic_percentageduration = toInteger(100 - ((modern_duration / total_duration) * 100)),
		primary_country = replace(primary_country, ' ', '')) ~> derivedColumn1
filter1 aggregate(groupBy(primary_country),
	total_count = count(primary_country),
		total_duration = sum(toInteger({standardized_duration(mins)}))) ~> aggregate2
silver select(mapColumn(
		show_id,
		type,
		movie_title,
		country,
		release_year,
		duration,
		release_category,
		standardized_duration_mins = {standardized_duration(mins)},
		is_last_10_years,
		primary_country
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> select1
derivedColumn1 sink(allowSchemaDrift: true,
	validateSchema: false,
	format: 'parquet',
	partitionFileNames:['gold_parquet.parquet'],
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	partitionBy('hash', 1)) ~> sink1