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
    A ChIP-seq peak calling workflow implemented in Nextflow.
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
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

---

## About The Project

This workflow implements a complete ChIP-seq peak calling pipeline. It includes data trimming, quality control, alignment, peak calling, annotation, and visualization steps.

### Key Features

- Adapter trimming with Trimmomatic  
- Quality control with FastQC and MultiQC  
- Read alignment using Bowtie2  
- Peak calling with MACS3  
- Blacklist filtering  
- Peak annotation and motif discovery with HOMER  
- Signal quantification and visualization using deepTools

### Built With

- [Nextflow](https://www.nextflow.io/)
- [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)
- [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
- [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
- [MACS3](https://github.com/macs3-project/MACS)
- [HOMER](http://homer.ucsd.edu/homer/)
- [deepTools](https://deeptools.readthedocs.io/)
- [MultiQC](https://multiqc.info/)

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

<!-- CONTACT -->
## Contact

Rachel - rbozadjian@gmail.com

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: www.linkedin.com/in/rachel-bozadjian-203999109
