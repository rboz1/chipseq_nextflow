#!/usr/bin/env nextflow

process SAMTOOLS_INDEX {
    container "ghcr.io/bf528/samtools:latest"
    label "process_high"
    publishDir params.outdir, mode: "copy"

    input:
    tuple val(name), path(bam)

    output:
    tuple val(name), path(bam), path("*.bai"), emit: index

    shell:
    """
    samtools index --threads $task.cpus $bam
    """
}