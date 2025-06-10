#!/usr/bin/env nextflow

process BIGWIG_SUMMARY{
    container "ghcr.io/bf528/deeptools:latest"
    label "process_medium"
    publishDir params.outdir

    input:
    path(bw)

    output:
    path("matrix.npz"), emit: matrix

    shell:
    """
    multiBigwigSummary bins -b ${bw.join(" ")} --smartLabels -o matrix.npz
    """
}