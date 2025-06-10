#!/usr/bin/env nextflow

process BOWTIE2_ALIGN{
    container "ghcr.io/bf528/bowtie2:latest"
    label "process_high"
    publishDir params.outdir

    input:
    tuple val(meta), path(reads)
    path(bt2)
    val(name)

    output:
    tuple val(meta), path("*.sam")
    tuple val(meta), path("*.bam"), emit: bam
    path("*_bowtie2.log"), emit: log

    shell:
    """
    bowtie2 --very-fast -p $task.cpus -x $bt2/$name -U ${reads} -S ${meta}.sam 2> ${meta}_bowtie2.log
    samtools view -bS ${meta}.sam > ${meta}.bam
    """
}