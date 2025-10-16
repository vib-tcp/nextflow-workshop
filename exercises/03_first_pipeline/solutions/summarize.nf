params.input = "$launchDir/data/crocodile_dataset.csv"
params.outdir = "$launchDir/results"

include { CSV_TO_TSV        } from "../modules/csv_to_tsv.nf"
include { SPLIT_BY_COUNTRY  } from "../modules/split_by_country.nf"
include { SUMMARIZE         } from "../modules/summarize/"

workflow {
    def input_ch = Channel.fromPath(params.input, checkIfExists:true)

    // Convert CSV to TSV
    CSV_TO_TSV(input_ch)

    // Split the TSV per country
    SPLIT_BY_COUNTRY(CSV_TO_TSV.out.tsv)

    def split_ch = SPLIT_BY_COUNTRY.out.country_files
        .flatten()
        .map { tsv ->
            // Get the country name from the filename
            def country = tsv.baseName
            [ country, tsv ]
        }

    // Create summary for each country
    SUMMARIZE(split_ch, input_ch.first())

    SUMMARIZE.out.summary.view()
}