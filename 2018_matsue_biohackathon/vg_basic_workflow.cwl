#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow


inputs:
  my_reference_genome:
    type: File
    secondaryFiles:
     - .fai
    format: edam:format_1929  # we need a IRI/URI for FASTA format

  my_genomic_varients:
    type: File
    secondaryFiles:
     - .tbi
    format: edam:format_3016  # VCF

steps:
  construct_graph:
    run: vg_construct.cwl
    in:
      reference_genome: my_reference_genome
      genomic_varients: my_genomic_varients
    out: [genome_graph]
  
  generate_layout:
    run: vg_view.cwl
    in:
      genome_graph: construct_graph/genome_graph
    out: [graph]

  render_pretty_picture_of_graph:
    run: render_pdf_from_dot.cwl
    in:
      dot_graph: generate_layout/graph
    out: [rendered_graph_image]

outputs:
  genome_graph:
    type: File
    outputSource: construct_graph/genome_graph
  pretty_picture: 
    type: File
    format: iana:application/pdf 
    outputSource: render_pretty_picture_of_graph/rendered_graph_image

$namespaces:
  iana: https://www.iana.org/assignments/media-types/
  edam: http://edamontology.org/
