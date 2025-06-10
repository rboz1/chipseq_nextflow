#!/usr/bin/env nextflow

process BEDTOOLS_BLACKLIST{
    container "ghcr.io/bf528/bedtools:latest"
    label "process_medium"
    publishDir params.outdir

    input:
    path(bed)
    path(blacklist)

    output:
    path("filtered_peaks.bed"), emit: filtered_peaks

    shell:
    """
    bedtools intersect -a $bed -b $blacklist -v -bed > filtered_peaks.bed
    """

}