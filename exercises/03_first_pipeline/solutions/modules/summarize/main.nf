process SUMMARIZE {
    container 'python:latest'

    input:
    tuple val(country), path(file)

    output:
    tuple val(country), path("*.txt"), emit: summary

    script:
    template "summarize.py"
}