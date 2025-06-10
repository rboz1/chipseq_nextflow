#!/usr/bin/env nextflow

process SAMTOOLS_SORT {
    container "ghcr.io/bf528/samtools:latest"
    label "process_single"
    publishDir params.outdir, mode: "copy"

    input:
    tuple val(name), path(bam)

    output:
    tuple val(name), path("*.sorted.bam"), emit: sorted

    shell:
    """
    samtools sort -@ $task.cpus $bam > ${name}.sorted.bam
    """
}