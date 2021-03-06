#!/bin/bash
#
#SBATCH -p privatecuda
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 1-2:00
#SBATCH -o slurm.%N.%j.out 
#SBATCH -e slurm.%N.%j.err

usage="""
Minimize Solvent
=================

Description
-----------
Shell script for minimizing solvent in AMBER GPU explict water simulation

Usage
-----
./minimize_solvent PARMFIL CRDFIL 
"""

module load gcc/4.9.2 cuda/7.0 ambertools/14 python/2.7.9
PATH=${PATH}:/home/akumar67/ngcchome/BetalactamaseGPURuns/scripts
AMBERHOME=/packages/6x/ambertools/14/

PARM=1l2yMD_TIP3P.prmtop
CRD=1l2yMD_TIP3P.inpcrd
title=$(echo $PARM | cut -d. -f1)


if [ -z "${PARM}" ]; 
then
    echo "NO PRMTOP FILE"
    echo "$usage" 
    exit 
fi

if [ -z "${CRD}" ];
then
    echo "NO CRD FILE"
    echo "$usage"
    exit 
fi 

echo $PARM
echo $CRD
echo $title 
echo $AMBERHOME

pwd 

#cp -v /home/akumar67/ngcchome/BetalactamaseGPURuns/scripts/minimization_solvent.in . 

${AMBERHOME}/bin/pmemd.cuda -O \
-i minimization_solvent.in \
-o minimization_solvent.out \
-p ${PARM} \
-c ${CRD} \
-r ${title}-min1.rst \
-ref ${CRD} \
