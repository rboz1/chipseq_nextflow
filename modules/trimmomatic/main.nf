#!usr/bin/env nextflow

process TRIMMOMATIC {
    container "ghcr.io/bf528/trimmomatic:latest"
    label "process_low"
    publishDir params.outdir

    input:
    tuple val(name), path(fastq)
    path(adapters)

    output:
    tuple val(name), path("*.trimmed.fastq.gz"), emit: trimmed
    path("*.trim.log"), emit: trimmed_log

    shell:
    """
    trimmomatic SE -phred33 $fastq "${name}.trimmed.fastq.gz" ILLUMINACLIP:$adapters:2:30:10 2> "${name}.trim.log"
    """
}
