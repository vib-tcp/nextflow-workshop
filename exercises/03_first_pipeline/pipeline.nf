#!/usr/bin/env nextflow

params.input = "$launchDir/data/crocodile_dataset.csv"

process CSV_TO_TSV {
    container 'ubuntu:latest'

    input:
    val csv_file

    output:
    path "output.tsv", emit: tsv

    script:
    """
    tr ',' '\\t' < ${csv_file} > output.tsv
    """
}

workflow {
    def input_ch = Channel.of(params.input)

    // Convert CSV to TSV
    CSV_TO_TSV(input_ch)
}