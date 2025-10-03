process PLOT {
    container 'community.wave.seqera.io/library/pip_pandas_plotly:dedffcf22ec0b56b'

    input:
    path summary_files

    output:
    path 'lengths.html', emit: lengths
    path 'weights.html', emit: weights

    script:
    """
    plot.py ${summary_files}
    """
}