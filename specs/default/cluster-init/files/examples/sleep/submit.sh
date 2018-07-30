#!/bin/bash
#
#SBATCH --job-name=sleep_x
#
#SBATCH --ntasks=4

singularity run sleep_x.ubuntu.img

