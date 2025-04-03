# Aggregating the WRF-Hydro Modeling Application output to twelve-digit hydrologic unit codes (HUC12s)

This workflow is a combination of shell scripts and jupyter notebooks that aggregate key variables from the 10-year WRF-Hydro Modeling Application forced with CONUS404-BA to CONUS water boundary dataset (WBD) HUC12s for the years 2010-2021. Additional steps are included in this workflow that make the outputs comparable to the [National Hydrologic Model/Precipitation-Runoff Modeling System (NHM/PRMS)](https://www.usgs.gov/mission-areas/water-resources/science/national-hydrologic-model-infrastructure) model outputs. 

Originally generated for NIWAA's data reports, the outputs from this workflow can be found here: [Monthly twelve-digit hydrologic unit code aggregations of the WRF-Hydro modeling application with CONUS404BA Atmospheric Forcings, 2009-2021](https://www.sciencebase.gov/catalog/item/6411fd40d34eb496d1cdc99d).

This workflow was written by Kevin Sampson and Aubrey Dugger and provided to USGS HyTEST team members. 

There are 4 major processes: 
1. Summarize variables from hourly to monthly
2. Aggregate variables to HUC12 basins
3. Merge 1-Dimensional and 2-dimensional variable aggregations together
4. Format final outputs

The following input files are needed for this workflow. A 3 year subset of these inputs have been downloaded to the HyTEST hovenweep area. Descriptions and download links are provided in the table below:

<table>
  <tr>
    <td colspan="5" align="center"><b>*/caldera/hovenweep/projects/usgs/water/impd/hytest/niwaa_wrfhydro_monthly_huc12_aggregations_sample_data</b></td>
  </tr>
  <tr>  
    <th>Dataset</th>
    <th>Model Output</th>
    <th>Description</th>
    <th>Link</th>
    <th>*Hovenweep Location</th>
  </tr>
  <tr>
    <td rowspan="4">WRF-Hydro</td>
    <td>LDASOUT</td>
    <td>Land model output variables.</td>
    <td rowspan="4"><a href="https://www.sciencebase.gov/catalog/item/661039a6d34e6334665050f4">WRF-Hydro forced CONUS404-BA NHDPLUSV2</a></td>
    <td>*/LDASOUT</td>
  </tr>
  <tr>
    <td>CHRTOUT</td>
    <td>Stream channel routing network.</td>
    <td>*/CHRTOUT</td>
  </tr>
  <tr>
    <td>GWOUT</td>
    <td>Conceptual groundwater output.</td>
    <td>*/GWOUT</td>
  </tr>
  <tr>
    <td>Static Files</td>
    <td>9 parameter files.</td>
    <td>*/static_niwaa_wrf_hydro_files</td>
  </tr>
  <tr>
    <td>CONUS404-BA</td>
    <td>LDASIN</td>
    <td>Bias adjusted climate variables.</td>
    <td><a href="https://www.sciencebase.gov/catalog/item/64f77acad34ed30c20544c18">CONUS404-BA</a></td>
    <td>*/LDASIN</td>
  </tr>
    <tr>
    <td rowspan="4">HUC12s</td>
    <td>1000m</td>
    <td>HUC12 attribution one-kilometer grid cell modeling domains.</td>
    <td rowspan="3"><a href="https://www.sciencebase.gov/catalog/item/6411fd40d34eb496d1cdc99d">HUC12 grids</a></td>
    <td>*/HUC12_grids/HUC12s_on_1000m_grid.tif</td>
  </tr>
  <tr>
    <td>250m</td>
    <td>HUC12 attribution to the 250-meter grid cell modeling domains.</td>
    <td>*/HUC12_grids/HUC12s_on_250m_grid.tif</td>
  </tr>
  <tr>
    <td>Crosswalk</td>
    <td>HUC12 spatial units, hydrofabric flowlines, and hydrofabric catchments, and two grid files.</td>
    <td>*/HUC12_grids/Final_HUC12IDs.tif</td>
  </tr>
  <tr>
    <td>WBD hu12</td>
    <td>WBD HUC12 geopackage containing character HUCIDs</td>
    <td><a href="https://www.sciencebase.gov/catalog/item/63cb38b2d34e06fef14f40ad">WBD gpkg</a></td>
    <td>*/HUC12_grids/HUC12.gpkg</td>
  </tr>
</table>


## Step 0: Prepping Datasets
Convert NIWAA WRF-Hydro simulation from 3-hourly to into monthly time steps. 
This process is done for each output type in the form of .sh scripts that can be run in command line.
The scripts are set up to run individual water years. 

The NIWAA WRF-Hydro files are available separated by calendar year (Jan-Dec). The shell scripts require the files to be separated by Water Year (Oct-Sep). This reorganization workflow was not provided by NCAR. 







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




## WILTING
There are fundamental differences in soil saturation representation between NHM-PRMS forced w/ C404 BA and WRFHydro forced w/ C404BA
wilting variables are being produced using Wrfhydro outputs in order to compare directly to NHM-PRMS modeling applications


# NCAR Notes: 
# niwaa_monthly_huc12_aggregations
Scripts to post-process WRF-Hydro National Integrated Water Availability Assessment (NIWAA) simulations into monthly HUC12 aggregations.

# wrf_hydro_model_tools
Supplementary scripts associated with the release of the WRF-Hydro community code

+ **[forcing/](/forcing)**
  + scripts for retrieval and regridding of meteorological forcing data
+ **[parameters/](/parameters)**
  + scripts for generating and modifying model parameter files
