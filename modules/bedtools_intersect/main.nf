#!/usr/bin/env nextflow

process BEDTOOLS_INTERSECT{
    container "ghcr.io/bf528/bedtools:latest"
    label "process_medium"
    publishDir params.outdir

    input:
    path(bed)

    output:
    path("reproducible_peaks.bed")

    shell:
    """
    bedtools intersect -a ${bed[0]} -b ${bed[1]} -f .75 -r > "reproducible_peaks.bed"
    """
}