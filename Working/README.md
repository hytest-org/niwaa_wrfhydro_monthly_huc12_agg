# HyTEST Notes:

## Step 0: Prepping Datasets
Convert NIWAA WRF-Hydro simulation from 3-hourly to into monthly time steps. 
This process is done for each output type in the form of .sh scripts that can be run in command line.
The scripts are set up to run individual years. 

### Note! NCO is required for this step to run. 
[netCDF Operator](https://nco.sourceforge.net/)

Installing NCO on Hovenweep: 


> [!TIP]
> Improvement: Eliminate need to install NCO independently. 


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
