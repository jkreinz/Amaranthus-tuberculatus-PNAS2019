#!/bin/bash
set -e
set -o pipefail
set -u

parallel -j10 -a popH2 --colsep '\t' ./denovoassembleEPSPS.sh 
parallel -j10 -a popG2 --colsep '\t' ./denovoassembleEPSPS.sh 
parallel -j10 -a popF2 --colsep '\t' ./denovoassembleEPSPS.sh 
parallel -j10 -a popD2 --colsep '\t' ./denovoassembleEPSPS.sh 
parallel -j10 -a popK2 --colsep '\t' ./denovoassembleEPSPS.sh 
parallel -j10 -a popB2 --colsep '\t' ./denovoassembleEPSPS.sh 
parallel -j10 -a popJ2 --colsep '\t' ./denovoassembleEPSPS.sh 
