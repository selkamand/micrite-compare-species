#!/usr/bin/env nextflow

// Run FASTQC and seqkit stats on a pair of reads belonging to a particular taxid. 
// Assumes reads ahave been extracted by EXTRACT_READS_BY_TAXID
process QC {
    tag "${meta.id}"
    cpus 1
    container 'selkamandcci/micrite-sleuth:0.0.2'

    input:
    tuple val(meta), path(r1), path(r2)

    output:
    tuple val(meta), path("${meta.id}.stats.tsv"), emit: seqkit
    tuple path("${meta.id}_R1_fastqc.zip"), path("${meta.id}_R2_fastqc.zip"), path("${meta.id}_R1_fastqc.html"), path("${meta.id}_R2_fastqc.html"), emit: fastqc

    script:
    """
    set -euo pipefail

    mkdir -p cache
    mkdir -p config

    export XDG_CACHE_HOME=cache
    export MPLCONFIGDIR=config

    fastqc -t ${task.cpus} --nogroup ${r1} ${r2}
    seqkit stats --threads ${task.cpus} --tabular ${r1} ${r2} > "${meta.id}.stats.tsv"
    """
}
