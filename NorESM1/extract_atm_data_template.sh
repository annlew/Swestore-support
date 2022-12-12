#!/bin/bash

# Example script fro extracting atmospheris NorESM data from Swestore
# Run the script with input parameters
#
# ./get_data exp_name var_name
#
# Example for extracting surface temperature
# ./get_data 10xSA_SO2 TS

# Swestore path to data
f="swestore:/snic/bolinc/NorESM1/AnnicaEkman/x_alewi/"$1"/atm/hist/"

echo $f

   # Filter data from 2050-2199 and only DJF
   #for g in $(rclone lsf $f | grep -E '(20[5-9]|21[0-9])' | grep -E '\-(01|02|12)' )

   # Filter data from 2050-2079 and only DJF
   for g in $(rclone lsf $f | grep -E '(20[5-7])' | grep -E '\-(01|02|12)' )

   do echo "'"$f$g"'" 
      echo "'"$g"'" 

      echo "'"$f$g"'" >> filelist_stat.txt

      # Copy filtered files from Swestore to local space
      rclone copyto $f$g  $g

      # Extract input variable and concatenate to produce time series
      cdo cat -selvar,$2 $g temp1.nc

   done

# Either remove all copied files when done
# rm $1*

# Or extract more variables from local data before deleting

# Remove temp files
#rm temp*
