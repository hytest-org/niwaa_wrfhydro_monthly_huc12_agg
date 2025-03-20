#!/bin/bash
############################################################################
# Parallelized bash shell script to move files organized by calendar year into new folders organized by water year.
#                
# Usage: Call shell script using associated slurm file
#      (cal_to_wy.slurm)
# Developed: 1/25/25, L. Staub
# Updated: 1/25/2025, L. Staub
############################################################################

############################################################################

# Set the directory where files are organized by calendar year
SOURCE_DIR="/caldera/hovenweep/projects/usgs/water/impd/hytest/working/niwaa_wrfhydro_monthly_huc12_aggregations/subset_CHRTOUT_hr"

echo "Beginning of loop"

# Record the start time
START_TIME=$(date +%s)

SOURCE_DIR="/path/to/source/folders"
TARGET_DIR="/path/to/target/folders"

# Accept the year directory as an argument
YEAR_DIR="$1"

# Extract the calendar year
YEAR=$(basename "$YEAR_DIR")

echo "Node $(hostname) processing files for year: $YEAR"

# Loop through each file in the calendar year folder
find "$YEAR_DIR" -type f | while read -r file; do
    # Extract the date from the filename (assuming format YYYYMMDD)
    filename=$(basename "$file")
    file_date="${filename:0:8}"  # First 8 characters are YYYYMMDD

    # Parse year, month, and day (ensure base-10 interpretation)
    file_year=${file_date:0:4}
    file_month=$((10#${file_date:4:2}))
    file_day=$((10#${file_date:6:2}))

    # Determine water year
    if [[ $file_month -ge 10 ]]; then
        # October or later, it belongs to the next calendar year's water year
        water_year=$((file_year + 1))
    else
        # Earlier months belong to the current calendar year's water year
        water_year=$file_year
    fi

    # Create target directory for the water year if it doesn't exist
    target_year_dir="$TARGET_DIR/$water_year"
    mkdir -p "$target_year_dir"

    # Add "WY_" prefix and copy the file to the water year folder
    cp "$file" "$target_year_dir/WY_$filename"
# Record the end time
END_TIME=$(date +%s)

# Calculate and print the elapsed time
ELAPSED_TIME=$((END_TIME - START_TIME))
echo "Script execution time: ${ELAPSED_TIME} seconds"