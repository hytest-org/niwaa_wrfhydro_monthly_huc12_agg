# Aggregating the WRF-Hydro Modeling Application output to twelve-digit hydrologic unit codes (HUC12s)
**Workflow Authors:** Kevin Sampson and Aubrey Dugger at NSF National Center for Atmospheric Research (NCAR)

Th aggregation workflow consists of 1 python script and 4 jupyter notebooks. The python script houses various functions that the jupyter notebooks calls to conduct calculations. This workflow aggregates key variables from the 10-year WRF-Hydro Modeling Application forced with CONUS404-BA to the CONtiguous United States (CONUS) water boundary dataset (WBD) HUC12s for the years 2010-2021. Additional steps are included in this workflow that prepare the data for publication and make the outputs comparable to the [National Hydrologic Model/Precipitation-Runoff Modeling System (NHM/PRMS)](https://www.usgs.gov/mission-areas/water-resources/science/national-hydrologic-model-infrastructure) model outputs. Originally generated for the National Integrated Water Availability Assessment (NIWAA) reports, the 10 year WRF-Hydro modeling application outputs were aggregated to HUC12 catchments by Kevin Sampson and Aubrey Dugger using NCAR HPC systems and published to [Science Base](https://www.sciencebase.gov/catalog/item/6411fd40d34eb496d1cdc99d).

## Input Data
The input data for this workflow consist of the WRF-Hydro modeling application monthly summaries outputs and static files. The monthly summaries are the outputs from the hourly to monthly section of this workflow. In addition to variables differing by dimension, they also differ by resolution. This requires different HUC12 grid sizes to be used in the aggregation. 

## Overview 
Tracking computation times for a 3 year subset of WRF-Hydro modeling application on USGS Hovenweep system.

| **Script** | **Description** | **Datasets processed** | **Dask** | **Time to complete** | **Output** | 
| ------ | ------ | ------ | ------ | ------ | ------ |
| 1-2D_spatial_aggregation | Aggregation to HUC12s of 2-Dimensional variables | monthly LDASOUT & LDASIN | Yes | XXX | XXX |
| 2-1D_spatial_aggregation | Aggregation to HUC12s of 1-Dimensional variables | monthly GWOUT & CHRTOUT | No | XXX | XXX |
| 3-Merge_1D_and_2D_files | Combine 1-Dimensional and 2-Dimensional aggregations into one netcdf file | --- | No | XXX | XXX |
| 4-Finalize | Formatting | --- | No | XXX | XXX |
| usgs_common | python script containg functions for workflow | --- | No | XXX | XXX |

## Compute Environment Needs
The python script and notebooks require a conda environment file to be created and activated before running. **wrfhydro_huc12_agg.yml** is the environment file needed to run the aggregation portion of the workflow. 
```
# cd to folder containing gdptools-env.yml and create the environment.
conda env create -f environment.yml

# activate conda environment
conda activate gdptools-env
```
Since this portion of the workflow utilizes Dask, it is important that the correct resources are allocated. The method used by the HyTEST team leverages the OnDemand Jupyter Notebook launcher hosted on [ARC HPC Portal](https://hpcportal.cr.usgs.gov/). When launching a jupyter notebook session, be sure to select **cpu** as the nodetype, a total of **2 cores**, and at least **150GB** of memory. This method allows you to enter the file path to where the clone of this repository is, as well as select an environment to activate. 

Although the aggregation portion of this workflow does not use 150GB at all times, the dask portion requires that much memory for the 2-Dimensional aggregation script. 

<table>
  <tr>
    <th>Source</th>
    <th>File</th>
    <th>Variables</th>
    <th>Type</th>
    <th>Grid</th>
  </tr>
  <tr>
    <td rowspan="19"><a href="#WRF-Hydro"><b>WRF-Hydro</b></a></td>
    <td rowspan="12">LDASOUT</td>
    <td>deltaACCET</td>
    <td>2D</td>
    <td>grid</td>
  </tr>
  <tr>
    <td>deltaACSNOW</td>
    <td>2D</td>
    <td>grid</td>
  </tr>
  <tr>
    <td>deltaSNEQV</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>deltaSOILM</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>deltaUGDRNOFF</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>deltaSOILM_depthmean</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>avgSNEQV</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>avgSOILM</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>avgSOILM_depthmean</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>avgSOILM_wltadj_depthmean</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>avgSOILSAT</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td>avgSOILSAT_wltadj_top1</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
  <tr>
    <td rowspan="4">GWOUT</td>
    <td>totOutflow</td>
    <td>1D</td>
    <td>grid</td> 
  </tr>
  <tr>
    <td>totInflow</td>
    <td>1D</td>
    <td>grid</td> 
  </tr>
  <tr>
    <td>deltaDepth</td>
    <td>1D</td>
    <td>grid</td> 
  </tr>
  <tr>
    <td>bucket_depth</td>
    <td>1D</td>
    <td>grid</td> 
  </tr>
  <tr>
    <td rowspan="3">CHRTOUT</td>
    <td>totqBucket</td>
    <td>1D</td>
    <td>grid</td> 
  </tr>
  <tr>
    <td>totqSfcLatRunoff</td>
    <td>1D</td>
    <td>grid</td> 
  </tr>
  <tr>
    <td>totStreamflow</td>
    <td>1D</td>
    <td>grid</td> 
  </tr>
  <tr>
    <td rowspan="2"><a href="#CONUS404-BA"><b>CONUS404-BA</b></a></td>
    <td rowspan="2">LDASIN</td>
    <td>totPRECIP</td>
    <td>2D</td>
    <td>grid</td>  
  </tr>
    <td>avgT2D</td>
    <td>2D</td>
    <td>grid</td>      
  </tr>
</table>
