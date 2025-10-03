process SPLIT_BY_COUNTRY {
    container 'python:latest'

    input:
    path tsv_file

    output:
    path "*.tsv", emit: country_files

    script:
    """
    split_by_country.py ${tsv_file}
    """
}