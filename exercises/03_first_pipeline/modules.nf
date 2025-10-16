params.input = "$launchDir/data/crocodile_dataset.csv"
params.outdir = "$launchDir/results"

include { CSV_TO_TSV        } from "./modules/csv_to_tsv.nf"
include { SPLIT_BY_COUNTRY  } from "./modules/split_by_country.nf"

workflow {
    def input_ch = Channel.fromPath(params.input, checkIfExists:true)

    // Convert CSV to TSV
    CSV_TO_TSV(input_ch)

    // Split the TSV per country
    SPLIT_BY_COUNTRY(CSV_TO_TSV.out.tsv)
}
