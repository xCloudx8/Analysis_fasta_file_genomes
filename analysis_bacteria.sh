#! /bin/bash

BACTERIA=(

  "NC_000913_E_COLI"
  "NC_000964_BACILLUS_SUTILIS"
  "NC_002754_SULFOLOBUS_SOLFATARICUS"
  "NC_005773_PSEUDOMONAS_SAVASTANOI"
  "NC_012589_SULFOLOBUS_ISLANDICUS"
  "NC_015518_ACIDIANUS_HOSPITALIS"
  "NC_005042_PROCHLOROCOCCUS_MARINUS"
  "NC_004923_AEROMONAS_SALMONICIDA"
  "NC_008570_AEROMONAS_HYDROPHILA"
)

for f in "${BACTERIA[@]}"
do
  echo "Done with GenomeStats for: " $f
   java -cp IGTools_cli.jar igtools.cli.GenomeStats /Project/Bacteria/Bacteria_3Bit/"$f".3bit /Project/Bacteria/Bacteria_nelsa/"$f".nelsa df -h | sed 's/  */\t/g' > /Project/Reports/Bacteria_Reports/"$f".csv
done

./order.py
echo "Ordered"

for f in "${BACTERIA[@]}"
do
   echo "Please wait Genome KStats for:  " $f
   java -cp IGTools_cli.jar igtools.cli.GenomeKStats "6" "24" /Project/Bacteria/Bacteria_3Bit/"$f".3bit /Project/Bacteria/Bacteria_nelsa/"$f".nelsa df -h | sed 's/  */\t/g' > /Project/Reports/Bacteria_Reports/FromK/"$f".csv
done

rm /Project/Reports/Bacteria_distr/mdistr/*.mdistr
rm /Reports/Bacteria_distr/minmaxavg/*.csv

echo "Removed all mdistr"

for f in "${BACTERIA[@]}"
  do
   for m in {6..24}
		do
      echo   "Analizing MultiplicityDistribution: "$f " " $m
      echo "-------------------------------------------------------------------------k=''$m'" >> /Project/Reports/Bacteria_distr/mdistr/"$f".mdistr
      java -cp IGTools_cli.jar igtools.cli.distributions.MultiplicityDistribution $m "a" /Project/Bacteria/Bacteria_3Bit/"$f".3bit /Project/Bacteria/Bacteria_nelsa/"$f".nelsa | awk '{min=9999}; /#/ {num+=1; tot+=$3; if ($3<min) min=$3; if ($3>max) max=$3} END{ print  min " " tot/num " " max }' >> /Project/Reports/Bacteria_distr/minmaxavg/"$f"min_max_avg.csv
      echo " " >> /home/daniele/Documents/Project/Reports/Bacteria_distr/mdistr/"$f".mdistr
      java -cp IGTools_cli.jar igtools.cli.distributions.MultiplicityDistribution $m "a" /Project/Bacteria/Bacteria_3Bit/"$f".3bit /Project/Bacteria/Bacteria_nelsa/"$f".nelsa >> /Project/Reports/Bacteria_distr/mdistr/"$f".mdistr
	 done
done

rm /Project/Reports/Bacteria_distr/rldistr/*.rldistr
echo "Removed all rldistr"

for f in "${BACTERIA[@]}"
  do
     sed -i '1d' /Project/Reports/Bacteria_Reports/FromK/"$f".csv
     sed -i '1d' /Project/Reports/Bacteria_Reports/FromK/"$f".csv
     sed -i '1d's/Project/Reports/Bacteria_Reports/FromK/"$f".csv
     sed -i '1d' /Project/Reports/Bacteria_Reports/FromK/"$f".csv
  for m in {1..100} 
  	do
      echo  "Analizing RepeatLengthDistribution: "$f " " $m
     echo "-------------------------------------------------------------------------k='$m'" >> /Project/Reports/Bacteria_distr/rldistr/"$f".rldistr
      java -cp IGTools_cli.jar igtools.cli.distributions.RepeatLengthDistribution $m "a" /Project/Bacteria/Bacteria_3Bit/"$f".3bit /Project/Bacteria/Bacteria_nelsa/"$f".nelsa >> /Project/Reports/Bacteria_distr/rldistr/"$f".rldistr
  	done
   sed -i '1 i\k	|D_k|	|H_k|	|R_k|	|T_k|	|E_k|' /Project/Reports/Bacteria_Reports/FromK/"$f".csv
done
./concatenating_bacteria.py

