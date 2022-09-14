#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$2
N_THREADS=$3
RUNMODE="genomeGenerate"
FASTAS=$4
GTF=$5

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

bash "$parent_path"/build.sh

docker run -v "$INPUT_DIR":/srv/input -v "$OUTPUT_DIR":/srv/output star_$(whoami) ./STAR --runThreadN "$N_THREADS" --runMode "$RUNMODE" --genomeDir /srv/output --genomeFastaFiles /srv/input/"$FASTAS" --sjdbGTFfile /srv/input/"$GTF"
