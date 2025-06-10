#!usr/bin/env nextflow

process FASTQC {
    container 'ghcr.io/bf528/fastqc:latest'
    label "process_low"
    publishDir params.outdir

    input:
    tuple val(name), path(fastq)

    output:
    path('*.zip'), emit: zip
    path('*.html'), emit: html

    shell:
    """
    fastqc -t $task.cpus $fastq
    """

}