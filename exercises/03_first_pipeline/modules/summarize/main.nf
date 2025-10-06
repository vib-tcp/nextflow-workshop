process SUMMARIZE {
    container 'python:latest'
    publishDir "${params.outdir}/summaries", mode: 'copy'

    input:
    tuple val(country), path(file)

    output:
    tuple val(country), path("*.txt"), emit: summary

    script:
    template "summarize.py"
}