# HyTEST Notes:

## Step 0: Prepping Datasets
Convert NIWAA WRF-Hydro simulation from 3-hourly to into monthly time steps. 
This process is done for each output type in the form of .sh scripts that can be run in command line.
The scripts are set up to run individual water years. 

The NIWAA WRF-Hydro files are available separated by calendar year (Jan-Dec). The shell scripts require the files to be separated by Water Year (Oct-Sep). This reorganization workflow was not provided by NCAR. 

> [!TIP]
> Improvement: Combine folder reorganization to water year step with hourly-monthly summary step. Or eliminate need to reorganize into water year in the first place?  

### Note! NCO is required for this step to run. 
[netCDF Operator](https://nco.sourceforge.net/)

The computers at NCAR already have an NCO module set up that allows for easier installation. The USGS HPC's do not have this module set up....YET. Lee Lopaka and Parker Norton are looking into nco to Hovenweep's list of pre-compiled modules.  

#### Installing NCO on Hovenweep: 
There are two methods. 
1. Use already compiled module in Parker Norton's home directory.
List all files in your home directory
```
ls -al
```
Open up your .bashrc file 
```
vim .bashrc
```
move your cursor to the bottom of the file and type 'a' to edit
add this line to you file
```
module use /home/pnorton/privatemodules
```
Hit esc to exit edit mode
type :wq to save and exit the file

Log out of HPC and log back in. Navigate back to your home directory and load the nco module. NOTE: This command will need to be run each time you log into HPC and plan to use nco tools. 
```
module load nco
```



2. Install nco into an Anaconda environment
```


```

> [!TIP]
> Improvement: Eliminate need to install NCO independently? 


Once nco is loaded, Step 0 can begin. There are 4 shell scripts total, one for each of the WRF-Hydro outputs to be aggregated. 
##### nco_process_ldasout.sh
You will need to specify three paths: 
  - The location of the 3-hourly WRF-Hydro output files.
  - The location of the static soil properties file.
  - The location of where to save the monthly outputs.
##### nco_process_gwout.sh

##### nco_process_clim.sh

##### nco_process_chrtout.sh

Once these details are modified in the shell script, they can be run using the following command- specifying which year to run the process on: 
```
./nco_process_ldasout.sh 2009
```
In order for the above command to run, I have to edit permission for the shell script: 
```
chmod +x /path/to/yourscript.sh
```




> [!TIP]
> Improvement: Two thoughts on this process
> 1. Keep this process as shell scripts, but find a way to specify it to run on more than 1 year.
> 2. convert to python notebook using coarsen package? 




## Step 2: Aggregations
Aggregate monthly WRF-Hydro monthly simulations to HUC12 catchments. 

### Note: the model inputs have different grid resoultions 
There are different grid resolutions available in HUC12 data release to use depending on model input being used. 

### Option 1: 2 Dimensional Aggregation


### Option 2: 1 Dimensional Aggregation

> [!IMPORTANT]
> Are both the 2D and 1D notebooks being performed on the same model inputs? At first glance it looks like the 1D notebook is just grabbing stats from the spatial units file. 







# NCAR Notes: 
# niwaa_monthly_huc12_aggregations
Scripts to post-process WRF-Hydro National Integrated Water Availability Assessment (NIWAA) simulations into monthly HUC12 aggregations.

# wrf_hydro_model_tools
Supplementary scripts associated with the release of the WRF-Hydro community code

+ **[forcing/](/forcing)**
  + scripts for retrieval and regridding of meteorological forcing data
+ **[parameters/](/parameters)**
  + scripts for generating and modifying model parameter files
