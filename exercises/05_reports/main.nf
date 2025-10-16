include { CSV_TO_TSV        } from "../03_first_pipeline/modules/csv_to_tsv.nf"
include { SPLIT_BY_COUNTRY  } from "../03_first_pipeline/modules/split_by_country.nf"
include { SUMMARIZE         } from "../03_first_pipeline/modules/summarize/"
include { PLOT              } from "../03_first_pipeline/modules/plot.nf"

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

    def summary_ch = SUMMARIZE.out.summary
        .map { _country, summary ->
            summary
        }
        .collect()

    // Plot the summaries
    PLOT(summary_ch)
    PLOT.out.lengths.view()
    PLOT.out.weights.view()

    workflow.onComplete = {
        println "Pipeline completed at: ${workflow.complete}"
        println "Time to complete workflow execution: ${workflow.duration}"
        println "Execution status: ${workflow.success ? 'Succesful' : 'Failed' }"
    }
}