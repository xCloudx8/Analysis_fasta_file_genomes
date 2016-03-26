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
   java -cp IGTools_cli.jar igtools.cli.util.FASTATo3bit /Project/Bacteria/"$f".fna "$f".3bit
   mv "$f.3bit" /Project/Bacteria/Bacteria_3Bit
   echo "$f done"
   echo ""
done

for f in "${BACTERIA[@]}"
do
   java -cp IGTools_cli.jar igtools.cli.dictionaries.BuildNELSA /Project/Bacteria/Bacteria_3Bit/"$f".3bit "$f".nelsa
   mv "$f.nelsa"/Project/Bacteria/Bacteria_nelsa
   echo "$f done"
   echo ""
done
