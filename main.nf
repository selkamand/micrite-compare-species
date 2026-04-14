nextflow.enable.dsl = 2

params {
    // Input is a samplesheet csv with columns: sample,r1,r2
    input: Path
    outdir: Path = "results"
}

include { QC } from './modules/local/qc.nf'


workflow {

    main:
    ch_samples = channel.fromPath(params.input)
        .splitCsv(header: true)
        .map { row ->
            def sample = row.sample as String
            def r1 = file(row.r1 as String)
            def r2 = file(row.r2 as String)

            if (!sample) {
                error("Missing sample column in samplesheet row: ${row}")
            }
            if (!r1.exists()) {
                error("FASTQ not found for sample ${sample}: ${r1}")
            }
            if (!r2.exists()) {
                error("FASTQ not found for sample ${sample}: ${r2}")
            }

            tuple([id: sample], r1, r2)
        }

    ch_qc_results = QC(ch_samples)

    publish:
    seqkit = ch_qc_results.seqkit
    fastqc = ch_qc_results.fastqc
}

output {
    seqkit {
        path "${params.outdir}/seqkit"
        mode 'copy'
    }
    fastqc {
        path "${params.outdir}/fastqc"
        mode 'copy'
    }
}
