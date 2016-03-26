#! /bin/bash

VIRUSES=(

  "Pseudomonas_phage_phi-6_segment_L"
  "Enterobacteria_phage_phiX174_sensu_lato"
  "Enterobacteria_phage_T4"
  "Bacillus_phage_phi29"
  #"Enterobacteria_phage_T5"
  "Sulfolobus_spindle-shaped_virus_4"
  "Enterobacteria_phage_M13"
  "Sulfolobus_islandicus_rod-shaped_virus_1"
  "Enterobacteria_phage_T7"
  "Escherichia_phage_P13374"
  "Acidianus_filamentous_virus_1"
  "Acidianus_two-tailed_virus"
  "Cyanophage_P-RSM6"
  "Aeromonas_phage_PX29"
  "Aeromonas_phage_Aeh1"

)

for f in "${VIRUSES[@]}"
	do
    echo "Done with GenomeStats for: " $f
    java -cp IGTools_cli.jar igtools.cli.GenomeStats /home/daniele/Documents/Project/Virus/Virus_3Bit/"$f".3bit /home/daniele/Documents/Project/Virus/Virus_nelsa/"$f".nelsa df -h | sed 's/  */\t/g' > /home/daniele/Documents/Project/Reports/Virus_Reports/"$f".csv
	done

cd /home/daniele/Documents/Project/Reports/Virus_Reports

./order.py

cd /home/daniele/Documents/Project

echo "Ordered"

for f in "${VIRUSES[@]}"
do
   echo "Please wait GenomeKStats for: " $f
   java -cp IGTools_cli.jar igtools.cli.GenomeKStats "6" "24" /home/daniele/Documents/Project/Virus/Virus_3Bit/"$f".3bit /home/daniele/Documents/Project/Virus/Virus_nelsa/"$f".nelsa df -h | sed 's/  */\t/g' > /home/daniele/Documents/Project/Reports/Virus_Reports/FromK/"$f".csv
done

rm /home/daniele/Documents/Project/Reports/Virus_distr/mdistr/*.mdistr
rm /home/daniele/Documents/Project/Reports/Virus_distr/minmaxavg/*.csv
echo "Removed all mdistr"

for f in "${VIRUSES[@]}"
	do
   for m in {6..24}
		do
	 	 echo   "Analizing MultiplicityDistribution: "$f " " $m
     echo "-------------------------------------------------------------------------k='$m'" >> /home/daniele/Documents/Project/Reports/Virus_distr/mdistr/"$f".mdistr
     java -cp IGTools_cli.jar igtools.cli.distributions.MultiplicityDistribution $m "a" /home/daniele/Documents/Project/Virus/Virus_3Bit/"$f".3bit /home/daniele/Documents/Project/Virus/Virus_nelsa/"$f".nelsa | awk '{min=9999}; /#/ {num+=1; tot+=$3; if ($3<min) min=$3; if ($3>max) max=$3} END{ print  min " " tot/num  "  " max }' >> /home/daniele/Documents/Project/Reports/Virus_distr/minmaxavg/"$f"min_avg_max.csv
     echo " " >> /home/daniele/Documents/Project/Reports/Virus_distr/mdistr/"$f".mdistr
		 java -cp IGTools_cli.jar igtools.cli.distributions.MultiplicityDistribution $m "a" /home/daniele/Documents/Project/Virus/Virus_3Bit/"$f".3bit /home/daniele/Documents/Project/Virus/Virus_nelsa/"$f".nelsa >> /home/daniele/Documents/Project/Reports/Virus_distr/mdistr/"$f".mdistr
	 done
done
#Calc min_Max_Avg

rm /home/daniele/Documents/Project/Reports/Virus_distr/rldistr/*.rldistr
echo "Removed all rldistr"

for f in "${VIRUSES[@]}"
	do
   sed -i '1d' /home/daniele/Documents/Project/Reports/Virus_Reports/FromK/"$f".csv
   sed -i '1d' /home/daniele/Documents/Project/Reports/Virus_Reports/FromK/"$f".csv
   sed -i '1d' /home/daniele/Documents/Project/Reports/Virus_Reports/FromK/"$f".csv
   sed -i '1d' /home/daniele/Documents/Project/Reports/Virus_Reports/FromK/"$f".csv
	for m in {1..100}
		do
		 echo  "Analizing RepeatLengthDistribution: "$f " " $m
     echo "------------------------------------------------------------------------- k='$m'" >> /home/daniele/Documents/Project/Reports/Virus_distr/rldistr/"$f".rldistr
	 	 java -cp IGTools_cli.jar igtools.cli.distributions.RepeatLengthDistribution $m "a" /home/daniele/Documents/Project/Virus/Virus_3Bit/"$f".3bit /home/daniele/Documents/Project/Virus/Virus_nelsa/"$f".nelsa >> /home/daniele/Documents/Project/Reports/Virus_distr/rldistr/"$f".rldistr
		done
		 sed -i '1 i\k	|D_k|	|H_k|	|R_k|	|T_k|	|E_k|' /home/daniele/Documents/Project/Reports/Virus_Reports/FromK/"$f".csv
	done

cd /home/daniele/Documents/Project/Reports/Virus_Reports

./concatenating_virus.py

cd /home/daniele/Documents/Project
