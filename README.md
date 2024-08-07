The macs2_bedtools Docker container is based on Ubuntu 22.04 and includes MACS2 and Bedtools. It provides two key scripts to facilitate its usage in HPC clusters:

**Peak calling**: peakcalling.sh run the macs2 callpeak command

*Usage*: docker run --rm -v $(pwd):/workspace macs2_bedtools:v1 /scripts/peak_calling.sh <input_file> <format> <genome_size> <keep_dup> [<control_file>] [--broad]

**Bed of peaks**: bedtools.sh takes the output of macs2 and keep common peaks between replicates. Then it runs bedtools to merge and sort peaks between conditions

*Usage*: docker run --rm -v $(pwd):/workspace macs2_bedtools:v1 /scripts/bedtools.sh <wt> <mutant> <peak_file_wt_1> <peak_file_wt_2> <peak_file_mut_1> <peak_file_mut_2>
