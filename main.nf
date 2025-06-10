#!/usr/bin/env nextflow

include { TRIMMOMATIC } from './modules/trimmomatic'
include { FASTQC } from './modules/fastqc'
include { BOWTIE2_INDEX } from './modules/bowtie2_index'
include { BOWTIE2_ALIGN } from './modules/bowtie2_align'
include { MULTIQC } from './modules/multiqc'
include { SAMTOOLS_INDEX } from './modules/samtools_index'
include { SAMTOOLS_SORT } from './modules/samtools_sort'
include { SAMTOOLS_FLAGSTAT } from './modules/samtools_flagstat'
include { BAMCOVERAGE } from './modules/deeptools_bamcoverage'
include { BIGWIG_SUMMARY } from './modules/deeptools_bwsummary'
include { PLOT_CORRELATION } from './modules/deeptools_plotcorr'
include { PEAK_CALL } from './modules/macs3_peakcall'
include { BEDTOOLS_INTERSECT } from './modules/bedtools_intersect'
include { BEDTOOLS_BLACKLIST } from './modules/bedtools_blacklist'
include { HOMER_ANNOTATE } from './modules/homer_annotate'
include { COMPUTE_MATRIX } from './modules/deeptools_computematrix'
include { HOMER_MOTIF } from './modules/homer_motifs'

workflow{
    Channel.fromPath(params.samplesheet)
        | splitCsv( header: true )
        | map{ row -> tuple(row.name, file(row.path)) }
        | set{ fastqc_ch }

    TRIMMOMATIC(fastqc_ch, params.adapter_fa)

    FASTQC(TRIMMOMATIC.out.trimmed)

    BOWTIE2_INDEX(params.genome)

    BOWTIE2_ALIGN(TRIMMOMATIC.out.trimmed, BOWTIE2_INDEX.out.index, BOWTIE2_INDEX.out.name)

    aligned = BOWTIE2_ALIGN.out.log
    zip = FASTQC.out.zip

    zip.mix(aligned).collect()
        | set{ multiqc_ch }

    MULTIQC(multiqc_ch)

    SAMTOOLS_SORT(BOWTIE2_ALIGN.out.bam)
    SAMTOOLS_INDEX(SAMTOOLS_SORT.out.sorted)
    SAMTOOLS_FLAGSTAT(BOWTIE2_ALIGN.out.bam)
    BAMCOVERAGE(SAMTOOLS_INDEX.out.index)

    BAMCOVERAGE.out.bigwig.map{ it[1] }.collect()
        | set{ bw_concat_ch }

    BIGWIG_SUMMARY(bw_concat_ch)
    PLOT_CORRELATION(BIGWIG_SUMMARY.out.matrix)

    // commented out below is for macs3 but ran into the error
    // SAMTOOLS_SORT.out.sorted
    //     | map{ it -> tuple(it[0].split("_")[1], it[1]) }
    //     | groupTuple(sort: true)
    //     | map{ it -> tuple(it[0], it[1].sort{ a, b -> a.name.compareTo(b.name) }) }
    //     | set{ peak_ch }

    // PEAK_CALL(peak_ch)

    // SAMTOOLS_SORT.out.sorted
    //     | map{ it -> tuple(it[0].split("_")[0], it[1]) }
    //     | groupTuple(sort: true)
    //     | set{ intersect_ch }

    peak_ch = Channel.fromPath(params.peaks).collect()

    BEDTOOLS_INTERSECT(peak_ch)
    BEDTOOLS_BLACKLIST(BEDTOOLS_INTERSECT.out, params.blacklist)

    HOMER_ANNOTATE(BEDTOOLS_BLACKLIST.out.filtered_peaks, params.genome, params.gtf)

    bw_concat_ch
        | map { it.toList().findAll { x -> !x.toString().contains("INPUT") } }
        | set{ bw_ip_ch }
    
    COMPUTE_MATRIX(bw_ip_ch, params.hg38_bed)

    HOMER_MOTIF(BEDTOOLS_BLACKLIST.out.filtered_peaks, params.genome)
}

