#!/usr/bin/env nextflow

process HOMER_ANNOTATE{
    container "ghcr.io/bf528/homer:latest"
    label "process_medium"
    publishDir params.outdir

    input:
    path(bed)
    path(genome)
    path(gtf)

    output:
    path("annotated_peaks.txt")

    shell:
    """
    annotatePeaks.pl $bed $genome -gtf $gtf > annotated_peaks.txt
    """
}