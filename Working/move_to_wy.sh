#!/bin/bash

# Define the base directory containing calendar year folders
#BASE_DIR="/path/to/calendar/years"

BASE_DIR="/caldera/hovenweep/projects/usgs/water/impd/hytest/niwaa_wrfhydro_monthly_huc12_aggregations/subset_niwaa_wrfhydro_hr/LDASOUT"


# Loop through each calendar year folder
for CAL_YEAR in "$BASE_DIR"/*; do
    # Check if it's a directory
    if [ -d "$CAL_YEAR" ]; then
        # Extract the year from the directory name
        YEAR=$(basename "$CAL_YEAR")

        # Determine the water year
        if (( 10#$YEAR < 10 )); then
            WATER_YEAR="20$(( YEAR + 1 ))"
        else
            WATER_YEAR="$(( YEAR + 1 ))"
        fi

        # Create the water year folder if it doesn't exist
        WATER_YEAR_DIR="$BASE_DIR/water_years/$WATER_YEAR"
        mkdir -p "$WATER_YEAR_DIR"

        # rename files to have WY prefix
	new_filename = "WY_$(basename "CAL_YEAR")"

        # Move files to the appropriate water year folder
        mv "$CAL_YEAR"/* "$WATER_YEAR_DIR/$new_filename"
        
        echo "Moved and renamed files from $CAL_YEAR to $WATER_YEAR_DIR"
    fi
done


