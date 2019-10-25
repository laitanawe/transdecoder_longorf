#!/usr/bin/env nextflow
/*
========================================================================================
                         lifebit-ai/qc-nf
========================================================================================
 lifebit-ai/qc-nf Template Nextflow pipeline to predict ORFs in Fasta Sequences 
 #### Homepage / Documentation
 
----------------------------------------------------------------------------------------
*/

Channel
  .fromPath( params.fasta )
  .ifEmpty { exit 1, "Cannot find any reads matching: ${params.fasta}\nNB: Path needs to be enclosed in quotes!\nNB: Path requires at least one * wildcard!\nIf this is single-end data, please specify --singleEnd on the command line." }
  .set { fish_orf_transdecoder }

/*--------------------------------------------------
  Run ORF prediction on Fasta Sequences
---------------------------------------------------*/

process transdecoder {
  
  publishDir params.outdir, mode: 'copy'

  input:
  file(fasta) from fish_orf_transdecoder

  output:
  file "*" into results

  script:
  """
  TransDecoder.LongOrfs -t $fasta
  """
}
