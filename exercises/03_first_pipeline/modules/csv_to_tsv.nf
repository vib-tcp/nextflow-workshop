process CSV_TO_TSV {
    container 'ubuntu:latest'
    publishDir "${params.outdir}/tsv", mode: 'copy'

    input:
    path csv_file

    output:
    path "*.tsv", emit: tsv

    script:
    """
    tr ',' '\\t' < ${csv_file} > ${csv_file.baseName}.tsv
    """
}