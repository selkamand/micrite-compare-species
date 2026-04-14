# selkamand/micrite-compare-species

## Introduction

**selkamand/micrite-compare-species** is a bioinformatics pipeline that performs simple QC of two different sets of reads from (usually) two different species to allow their outputs to be compared.


## Usage

> [!NOTE]
> If you are new to Nextflow please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. Make sure to [test your setup](https://nf-co.re/docs/usage/introduction#how-to-run-a-pipeline) with `-profile test` before running the workflow on actual data.

To start using this pipeline, prepare a samplesheet (csv). 
For example, if you wanted to compare two readsets, one from genus `homo`, and one from the `bacteria` superfamily it might look like the following:

Reads can be extracted using micrite-screen, micrite-sleuth, or micrite-gethuman pipelines

```
sample,r1,r2
homo,path/to/r1.fq,path/to/r2.fq
bacteria,path/to/r1.fq,path/to/r2.fq
```

Now, you can run the pipeline using:


```bash
nextflow run selkamand/micrite-compare-species \
   -profile <docker/singularity/.../> \
   --input samplesheet.csv \
   --outdir <OUTDIR>
```

> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_; see [docs](https://nf-co.re/docs/usage/getting_started/configuration#custom-configuration-files).

## Credits

selkamand/micrite-compare-species was originally written by Sam El-Kamand.

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

## Citations


An extensive list of references for the tools used by the pipeline can be found in the [`CITATIONS.md`](CITATIONS.md) file.

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
