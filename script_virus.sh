#!/bin/bash

VIRUSES=(

  #"Pseudomonas phage phi-6 segment L"
  #"Enterobacteria phage phiX174 sensu lato"
  #"Enterobacteria phage T4"
  #"Bacillus phage phi29"
  #"Enterobacteria phage T5"
  #"Sulfolobus spindle-shaped virus 4"
  #"Enterobacteria phage M13"
  #"Sulfolobus islandicus rod-shaped virus 1"
  #"Enterobacteria phage T7"
  #"Escherichia phage P13374"
  #"Acidianus filamentous virus 1"
  #"Acidianus two-tailed virus"
  #"Cyanophage P-RSM6"
  "Aeromonas phage PX29"
  "Aeromonas phage Aeh1"
  )

for f in "${VIRUSES[@]}"
do

  echo "$f"
  sed -ne '/'"$f"'/,/>gi/ p' viral.1.1.genomic.fna | sed '$ d' > /home/daniele/Documents/Project/Virus/Virus_fna/"$f".fna

done

cd /home/daniele/Documents/Project/Virus/Virus_fna

rename 's/ /_/g' *
echo "Renamed"

VIRUSESs=(

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
  #"Cyanophage_P-RSM6"
  "Aeromonas_phage_PX29"
  "Aeromonas_phage_Aeh1"
)

for f in "${VIRUSESs[@]}"
do

 sed -i s/^.*\;.*$//g "$f".fna
 sed -i s/^.*\>.*$/N/g "$f".fna

done

cd /home/daniele/Documents/Project/
echo "Virus DONE"
