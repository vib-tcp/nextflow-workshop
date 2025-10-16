process SUMMARIZE {
    container 'python:latest'
    publishDir "${params.outdir}/summaries", mode: 'copy'

    input:
    tuple val(country), path(file)
    path(input_tsv)

    output:
    tuple val(country), path("*.txt"), emit: summary

    script:
    template "summarize.py"
}