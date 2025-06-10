#!/usr/bin/env nextflow

process HOMER_MOTIF{
    container "ghcr.io/bf528/homer:latest"
    label "process_medium"
    publishDir params.outdir

    input:
    path(filtered_peaks)
    path(genome)

    output:
    path("homer_motifs/*html")

    shell:
    """
    mkdir homer_motifs/
    findMotifsGenome.pl $filtered_peaks $genome homer_motifs/
    """
}