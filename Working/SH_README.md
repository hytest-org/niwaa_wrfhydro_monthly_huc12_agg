# Hourly to Monthly Workflow

## Overview
NCO is required for this workflow: [netCDF Operator](https://nco.sourceforge.net/). USGS HPC Hovenweep has an NCO module set up that needs to be loaded before the workflow is run. 

To keep processing times low, this workflow has been parallelized. There are 4 variables that need to be converted from hourly to monthly: LDASOUT, LDASIN, CHRTOUT, and GWOUT. Each variable has a shell script that does the hourly to monthly calculations. These can be run for a single year or called into a slurm file to run multiple years at once. 

| **Source** | **Variable** | **File Structure** | **Time Step** | **Shell Script** | **Slurm file** |
| ------ | ------ | ------ | ------ | ------ | ------ |
| WRF-Hydro | LDASOUT | Calendar Year | 3-hourly | nco_process_ldasout.sh | ldasout_nco.slurm |
| CONUS404-BA | LDASIN | Water Year | hourly | nco_process_clim.sh | clim_nco.slurm |
| WRF-Hydro | GWOUT | Calendar Year | hourly | nco_process_gwout.sh | gwout_nco.slurm |
| WRF-Hydro | CHRTOUT | Calendar Year | hourly | nco_process_chrtout.sh | chrtout_nco.slurm |


NOTE FOR LES: The shell scripts are set up as though they can be run for 1 year or called into a slurm script. We don't need to have two versions of the same shell script. Need to rename these files and reorganize them.  

## Script Preparations:
##### nco_process_ldasout.sh
You will need to specify three paths: 
  - The location of the 3-hourly WRF-Hydro output LDASOUT files.
  - The location of the static soil properties file.
  - The location of where to save the monthly outputs.

##### nco_process_gwout.sh
You will need to specify two paths: 
  - The location of the hourly WRF-Hydro output GWOUT files.
  - The location of where to save the monthly outputs.
*Note: this script has some additional lines of code to deal with filetypes in the depth variable. Renaming the variable seems to fix this bug. Another option is to use older version of the NCO module- this has not been explored yet.

##### nco_process_clim.sh
You will need to specify two paths: 
  - The location of the hourly CONUS404-BA output LDASIN files.
  - The location of where to save the monthly outputs.
*Note: this script has some additional lines of code to deal with this data being organized by Water Year.

##### nco_process_chrtout.sh
You will need to specify two paths: 
  - The location of the hourly WRF-Hydro output CHRTOUT files.
  - The location of where to save the monthly outputs.
  
## One Year at a Time: 

Load netcdf operator
```
module load nco
```
Ensure paths in shell script are correct. 

Allow edit permission for the shell script:
```
chmod +x /path/to/yourscript.sh
```
Run the shell script. 
```
./nco_process_ldasout.sh 2009
```
Repeat for other variables. 



## Multiple Years at Once: 

Ensure paths in shell script and slurm file are correct. 

Allow edit permission for the shell script:
```
chmod +x /path/to/yourscript.sh
```
Launch slurm script with an array of years of interest, 2011-2013 is used here. 
```
sbatch --array=2011-2013 ldasout_nco.slurm
```
To check on the status of slurm request:
```
squeue -u <username>
```
If you need to cancel the request: 
```
scancel <jobid>
```









# NCAR Notes: 
# niwaa_monthly_huc12_aggregations
Scripts to post-process WRF-Hydro National Integrated Water Availability Assessment (NIWAA) simulations into monthly HUC12 aggregations.

# wrf_hydro_model_tools
Supplementary scripts associated with the release of the WRF-Hydro community code

+ **[forcing/](/forcing)**
  + scripts for retrieval and regridding of meteorological forcing data
+ **[parameters/](/parameters)**
  + scripts for generating and modifying model parameter files
