#! /bin/bash

VIRUSES=(

"Pseudomonas_phage_phi-6_segment_L"
"Enterobacteria_phage_phiX174_sensu_lato"
"Enterobacteria_phage_T4"
"Bacillus_phage_phi29"
"Enterobacteria_phage_T5"
"Sulfolobus_spindle-shaped_virus_4"
"Enterobacteria_phage_M13"
"Sulfolobus_islandicus_rod-shaped_virus_1"
"Enterobacteria_phage_T7"
"Escherichia_phage_P13374"
"Acidianus_filamentous_virus_1"
"Acidianus_two-tailed_virus"
"Halo_virus_PH1"
"Syneochoccus_phage_S-CBS1"
"Actinoplanes_phage_phiAsp2"
"Cyanophage_P-RSM6"
"Hypertermophilic_Archaeal_Virus1"
"Aeromonas_phage_PX29"
"Aeromonas_phage_Aeh1"

)

for f in "${VIRUSES[@]}"
do
   java -cp IGTools_cli.jar igtools.cli.util.FASTATo3bit /Project/Virus/"$f".fna "$f".3bit
   mv "$f.3bit" /Project/Virus/Virus_3Bit
   echo "$f done"
   echo ""
done

for f in "${VIRUSES[@]}"
do
   java -cp IGTools_cli.jar igtools.cli.dictionaries.BuildNELSA /Project/Virus/Virus_3Bit/"$f".3bit "$f".nelsa
   mv "$f.nelsa" /Project/Virus/Virus_nelsa
   echo "$f done"
   echo ""
done
