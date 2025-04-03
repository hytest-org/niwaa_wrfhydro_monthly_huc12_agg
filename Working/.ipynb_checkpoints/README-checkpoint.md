# Aggregating the WRF-Hydro Modeling Application output to twelve-digit hydrologic unit codes (HUC12s)
**Workflow Authors:** Kevin Sampson and Aubrey Dugger at NSF National Center for Atmospheric Research (NCAR)

This workflow is a combination of shell scripts and jupyter notebooks that aggregate key variables from the 10-year WRF-Hydro Modeling Application forced with CONUS404-BA to the CONtiguous United States (CONUS) water boundary dataset (WBD) HUC12s for the years 2010-2021. Additional steps are included in this workflow that prepare the data for publication and make the outputs comparable to the [National Hydrologic Model/Precipitation-Runoff Modeling System (NHM/PRMS)](https://www.usgs.gov/mission-areas/water-resources/science/national-hydrologic-model-infrastructure) model outputs. Originally generated for the National IWAA's data reports, the 10 year WRF-Hydro modeling application outputs were aggregated to HUC12 catchments by Kevin Sampson and Aubrey Dugger using NCAR HPC systems and published to [Science Base](https://www.sciencebase.gov/catalog/item/6411fd40d34eb496d1cdc99d).

## Workflow Overview
There are 4 major processes: 
1. Summarize variables from hourly to monthly
2. Aggregate variables to HUC12 basins
3. Merge 1-Dimensional and 2-Dimensional variable aggregations together
4. Format final outputs

## Input Data
The following input files are needed for this workflow. A 3 year subset of these inputs have been downloaded to the HyTEST hovenweep area. Descriptions and download links are provided in the table below:

<table>
  <tr>
    <td colspan="5" align="center"><b>*/caldera/hovenweep/projects/usgs/water/impd/hytest/niwaa_wrfhydro_monthly_huc12_aggregations_sample_data</b></td>
  </tr>
  <tr>  
    <th>Dataset</th>
    <th>Model Output</th>
    <th>Description</th>
    <th>Source</th>
    <th>*Hovenweep Location</th>
  </tr>
  <tr>
    <td rowspan="4"><a href="#WRF-Hydro"><b>WRF-Hydro</b></a></td>
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
    <td><a href="#CONUS404-BA"><b>CONUS404-BA</b></a></td>
    <td>LDASIN</td>
    <td>Bias adjusted climate variables.</td>
    <td><a href="https://www.sciencebase.gov/catalog/item/64f77acad34ed30c20544c18">CONUS404-BA</a></td>
    <td>*/LDASIN</td>
  </tr>
    <tr>
    <td rowspan="4"><a href="#HUC12s"><b>HUC12s</b></a></td>
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
    <td>WBD HUC12</td>
    <td>WBD HUC12 geopackage containing character HUCIDs</td>
    <td><a href="https://www.sciencebase.gov/catalog/item/63cb38b2d34e06fef14f40ad">WBD gpkg</a></td>
    <td>*/HUC12_grids/HUC12.gpkg</td>
  </tr>
</table>

<a id="WRF-Hydro"></a>
<h3>WRF-Hydro Background</h3>

![Screenshot](images/wrf-hydro_logo.png)

The Weather Research and Forecasting Hydrological modeling system ([WRF-Hydro](https://ral.ucar.edu/projects/wrf_hydro)) provides water budget estimates across space and time by linking process models of the atmosphere and terrestrial hydrology. The image below has the output files organized by model physics component with the files used in this workflow highlighted.

![Screenshot](images/wrf-hydro_outputs2.png)

Want to learn more about the WRF-Hydro Modeling System? [These tutorial recordings](https://doimspp.sharepoint.com/sites/gs-wma-hytest/SitePages/WRF-Hydro-Modeling-System-Hands-on-Tutorial.aspx?xsdata=MDV8MDJ8fDRlMzY5NWMwMTU1MzRiYzEyZjNkMDhkZDcxMzA3YjVmfDA2OTNiNWJhNGIxODRkN2I5MzQxZjMyZjQwMGE1NDk0fDB8MHw2Mzg3OTExNzUxOTg2ODI5NDF8VW5rbm93bnxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxMMk5vWVhSekx6RTVPamcwTlRNME1EQmhMVEF5WldRdE5HVXpPUzFoTW1VMkxUZGhOMlJoWWpsak5UYzBaVjlsWWpVME1UazRNeTAwWVdSaUxUUTNZbU10WVRZeFpTMWhNR1V6WVdRMVl6a3hNV05BZFc1eExtZGliQzV6Y0dGalpYTXZiV1Z6YzJGblpYTXZNVGMwTXpVeU1EY3hPRGc1TWc9PXw1ZTFlYjM2NzA4MWQ0YjZiY2NkNjA4ZGQ3MTMwN2I1Y3w0OTYwODE5NzFjMmQ0ZWMyOTA5MmVlNmVhMzE1OWEyZA%3D%3D&sdata=UDZvaGNyMktQcXZic3pDdmI5NEpOUFhkdnhCNjZOVTlzYll3cmk1OTM4UT0%3D&ovuser=0693b5ba-4b18-4d7b-9341-f32f400a5494%2Clstaub%40usgs.gov&OR=Teams-HL&CT=1743697590477&clickparams=eyJBcHBOYW1lIjoiVGVhbXMtRGVza3RvcCIsIkFwcFZlcnNpb24iOiI0OS8yNTAzMTMyMTAxMiIsIkhhc0ZlZGVyYXRlZFVzZXIiOmZhbHNlfQ%3D%3D) are a great resource and [this document](https://ral.ucar.edu/sites/default/files/docs/water/wrf-hydro-v511-technical-description.pdf) provides even more technical details! This workflow uses the land model (LDASOUT), stream channel routing (CHRTOUT), and conceptual groundwater (GWOUT) outputs from a version of the WRF-Hydro Modeling system that is forced with CONUS404-BA.

<a id="CONUS404-BA"></a>
<h3>CONUS404-BA Background</h3>

[CONUS404](https://www.sciencebase.gov/catalog/item/6372cd09d34ed907bf6c6ab1) is a high resolution hydro-climate dataset used for forcing hydrological models and covers 43 years of data at 4km resolution. Two separate fields (2-meter air temperature and precipitation) in this dataset had biases identified, leading to the development of a new product [CONUS404-BA](https://www.sciencebase.gov/catalog/item/64f77acad34ed30c20544c18). This dataset has downscaled the CONUS404 dataset from 4km to 1km, and bias adjusted the 2-meter air temperature and precipitation fields using Daymet version 3 as the background observational reference. This workflow uses the precipitation and rainrate fields from the CONUS404-BA output (LDASIN).  

<a id="HUC12s"></a>
<h3>WBD HUC12s Background</h3>
The Watershed Boundary Dataset 12-digit hydrologic unit code catchments 

## Compute Environment Needs
The 10-year WRF-Hydro Modeling Application forced with CONUS404-BA is comprised of 12 years of hourly data (2009-2011). The following information was gathered to better understand computational needs:
There are three leap years during this time span (2012, 2016, and 2020). There are 4 variables total: LDASOUT, LDASIN, CHRTOUT, and GWOUT. LDASOUT, CHRTOUT, and GWOUT each have 1 netcdf file for each hour in a day (24 files per day) while LDASOUT has 1 netcdf for every 3 hours (8 files per day). 

| **Source** | **Variable** | **File Structure** | **Time Step** | **Total Number of Files** | **Size** |
| ------ | ------ | ------ | ------ | ------ | ------ |
| WRF-Hydro | LDASOUT | Calendar Year | 3-hourly | ~35,064 | ~7,000 GB |
| CONUS404-BA | LDASIN | Water Year | hourly | ~105,192 | ~21,000 GB |
| WRF-Hydro | GWOUT | Calendar Year | hourly | ~105,192 | ~21,000 GB |
| WRF-Hydro | CHRTOUT | Calendar Year | hourly | ~105,192 | ~21,000 GB |

This means that there are roughly ~350,640 files used as inputs to this workflow that will take up at least 70,000 GBs worth of storage space. Because of these file sizes, this workflow was developed using High Processing Computer (HPC) systems. To save on storage space, a three year subset of these data were downloaded to the USGS HPC system, Hovenweep. The workflow in this repository is currently set up to run on this temporal subset of data (2011, 2012, and 2013) but can be modified to include a larger time scale. 








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
