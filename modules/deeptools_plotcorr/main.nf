#!/usr/bin/env nextflow

process PLOT_CORRELATION{
    container "ghcr.io/bf528/deeptools:latest"
    label "process_medium"
    publishDir params.outdir

    input:
    path(matrix)

    output:
    path("plot.png")

    shell:
    """
    plotCorrelation -in $matrix -c spearman -p heatmap -o plot.png
    """
}