#!/usr/bin/env nextflow

process BAMCOVERAGE {
    container "ghcr.io/bf528/deeptools:latest"
    label "process_medium"
    publishDir params.outdir, mode: "copy"

    input:
    tuple val(name), path(bam), path(bai)

    output:
    tuple val(name), path("*.bw"), emit: bigwig

    shell:
    """
    bamCoverage -b $bam -o ${name}.bw -p $task.cpus
    """

}