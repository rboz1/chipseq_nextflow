<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
  <h3 align="center">ChIP-seq Peak Calling</h3>

  <p align="center">
    A comprehensive ChIP-seq peak calling and downstream analysis workflow implemented in Nextflow, with differential expression analysis integration.
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Script</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#results">Results</a></li> 
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

---

## About The Project

A comprehensive ChIP-seq peak calling and downstream analysis workflow implemented in Nextflow, integrating peak detection, annotation, motif discovery, and functional enrichment with RNA-seq differential expression analysis for biological insights.

### Key Features

- Adapter trimming with Trimmomatic  
- Quality control with FastQC and MultiQC  
- Read alignment using Bowtie2  
- Peak calling with MACS3  
- Blacklist filtering using ENCODE
- Peak annotation and motif discovery with HOMER  
- Signal quantification and visualization using deepTools
- Differential expression analysis integration using custom Python script

### Built With

- [Nextflow](https://www.nextflow.io/)
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
- [MACS3](https://github.com/macs3-project/MACS)
- [HOMER](http://homer.ucsd.edu/homer/)
- [deepTools](https://deeptools.readthedocs.io/)
- [MultiQC](https://multiqc.info/)
- Python

---

## Getting Started

### Prerequisites

- [Nextflow](https://www.nextflow.io/)
- Installed tools and reference data (genome FASTA, annotation files, adapters, etc.)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/rboz1/chipseq_nextflow.git
2. Create and activate conda environment 
   ```
   conda env create -f base_env.yml
   conda activate nextflow_base
3. Run pipeline
   ```
   nextflow run main.nf -profile conda,cluster

   ** please update your cluster in the nextflow.config if it isn't sge **
<p align="right">(<a href="#readme-top">back to top</a>)</p>

---

## Results

- **Enrichment analysis**:  
  Protein-coding genes associated with high-scoring peaks (>1000) were submitted to EnrichR for functional enrichment. Analysis focused on:  
  - **GO Biological Processes**: Revealed significant enrichment in pathways related to positive regulation of signal transduction and the Notch signalling pathway - a critical developmental signaling cascade often dysregulated in cancer.
  - **ChEA 2022 Transcription Factor Targets**: Identified key transcription factors potentially regulating these genes with **RUNX1** prominently enriched.
    
  <img width="806" height="300" alt="enrichr_bar_chart" src="https://github.com/user-attachments/assets/1577aedf-85b4-490e-ad24-784f1afdfb5b" />

- **Motif discovery results**:  
  Identified sequence motifs and candidate transcription factors from peak regions, with **RUNX1** motifs frequently observed, reinforcing its biological relevance alongside enrichment analysis results.
  
  <img width="1507" height="787" alt="motif_screenshot" src="https://github.com/user-attachments/assets/a7c0b47d-09af-42ba-a0f3-f93fdf25dc2e" />

- **Integration with RNA-seq data**:  
  By combining RNA-seq differential expression data with RUNX1 ChIP-seq peak annotations, we analyzed the proximity of RUNX1 binding sites relative to the transcription start site (TSS) of upregulated and downregulated genes.  
  - A significant proportion of **upregulated genes** show RUNX1 binding within ±5 kb and ±20 kb of their TSS compared to downregulated genes.  
  - This suggests RUNX1 binding near TSS correlates with gene activation, supporting its role as a key regulator in this context.  
  - The data were visualized as a stacked bar plot illustrating the percentage of genes bound or not bound by RUNX1 near their TSS in these gene sets.
    
  <img width="824" height="602" alt="Screenshot 2025-07-29 at 12 25 07 PM" src="https://github.com/user-attachments/assets/d8044c2e-2d4d-45d3-873d-965a6153c5c1" />
  <p align="right">(<a href="#readme-top">back to top</a>)</p>
---

### Next steps:

- Integrating ChIP-seq and RNA-seq data specifically for Notch pathway genes to better understand the regulatory impact of RUNX1 binding.  
- Expanding analysis to assess co-binding patterns between RUNX1 and other transcription factors to uncover potential regulatory complexes.  

<!-- CONTACT -->
## Contact

Rachel - rbozadjian@gmail.com

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: www.linkedin.com/in/rachel-bozadjian-203999109
