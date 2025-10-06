process SPLIT_BY_COUNTRY {
    container 'python:latest'
    publishDir "${params.outdir}/country_subsets", mode: 'copy'

    input:
    path tsv_file

    output:
    path "*.tsv", emit: country_files

    script:
    """
    split_by_country.py ${tsv_file}
    """
}