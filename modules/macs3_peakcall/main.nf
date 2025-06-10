#!/usr/bin/env nextflow

process PEAK_CALL{
    container "ghcr.io/bf528/macs3:latest"
    label "process_high"
    publishDir params.outdir

    input:
    tuple val(name), path(files)

    output:
    tuple val(name), path("*.narrowPeak"), emit: peaks

    shell:
    """
    macs3 callpeak -t ${files[1]} -c ${files[0]} -f BAM -n $name -g hs
    """
}