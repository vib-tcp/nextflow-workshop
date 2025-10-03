#!/usr/bin/env nextflow

params.input = "$launchDir/data/boardgames.csv" // $projectDir is another interesting implicit variable

/**
 * Count the lines of the file
 */
    
process line_counter {
    input:
    path input  
    
    output:
    stdout

    script:
    """
    wc -l ${input}
    """
}

workflow {
    def inputs_ch = Channel
        .fromPath( params.input )
        .view()

    line_counter(inputs_ch).view()
}