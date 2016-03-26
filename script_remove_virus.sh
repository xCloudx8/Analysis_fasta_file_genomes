#! /bin/bash

VIRUSES=(

  #"Pseudomonas_phage_phi-6_segment_L"
  #"Enterobacteria_phage_phiX174_sensu_lato"
  #"Enterobacteria_phage_T4"
  #"Bacillus_phage_phi29"
  #"Enterobacteria_phage_T5"
  #"Sulfolobus_spindle-shaped_virus_4"
  #"Enterobacteria_phage_M13"
  #"Sulfolobus_islandicus_rod-shaped_virus_1"
  #"Enterobacteria_phage_T7"
  #"Escherichia_phage_P13374"
  #"Acidianus_filamentous_virus_1"
  #"Acidianus_two-tailed_virus"
  #"Halo_virus_PH1"
  #"Actinoplanes_phage_phiAsp2"
  #"Cyanophage_P-RSM6"
  #"Hypertermophilic_Archaeal_Virus1"
  "Aeromonas_phage_PX29"
  "Aeromonas_phage_Aeh1"
)

for f in "${VIRUSES[@]}"
do

 sed -i s/^.*\;.*$//g "$f".fna
 sed -i s/^.*\>.*$/N/g "$f".fna

done

echo "Virus DONE"
