#!/usr/bin/env nextflow

process COMPUTE_MATRIX{
    container "ghcr.io/bf528/deeptools:latest"
    label "process_low"
    publishDir params.outdir

    input:
    path(bw)
    path(hg38_bed)

    output:
    path("matrix.mat.gz")
    path("ip_read_counts.png")

    shell:
    """
    computeMatrix scale-regions -S ${bw.join(" ")} -R $hg38_bed -b 2000 -a 2000 -o matrix.mat.gz
    plotProfile -m matrix.mat.gz -o ip_read_counts.png
    """
}