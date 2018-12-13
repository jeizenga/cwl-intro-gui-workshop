#!/usr/env/bin cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: Represent a genome graph in graphviz .dot format

#hints:
#  DockerRequirement:
#    dockerPull: quay.io/vgteam/vg:dev-v1.12.1-51-g28ef4e32-t258-run
#  SoftwareRequirement:
#    packages:
#      vg:
#        version: ["1.12.1"]
#        specs: [ https://doi.org/10.1038/nbt.4227 ]

inputs:
  dot_graph:
    type: File
    inputBinding:
      position: 1
    format: iana:text/vnd.graphviz

baseCommand: [ dot ]

arguments:
  - -Tpdf
  - prefix: -o
    valueFrom: $(inputs.dot_graph.basename).pdf

outputs:
  rendered_graph_image:
    type: File
    outputBinding:
      glob: $(inputs.dot_graph.basename).pdf
    format: iana:application/pdf
      
$namespaces:
  iana: https://www.iana.org/assignments/media-types/
