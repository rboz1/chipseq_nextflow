#!/usr/bin/env nextflow

process SAMTOOLS_FLAGSTAT {
    container "ghcr.io/bf528/samtools:latest"
    label "process_low"
    publishDir params.outdir

    input:
    tuple val(name), path(bam)

    output:
    tuple val(name), path("*flagstat.tsv")

    shell:
    """
    samtools flagstat $bam -O tsv > ${name}_flagstat.tsv
    """

}