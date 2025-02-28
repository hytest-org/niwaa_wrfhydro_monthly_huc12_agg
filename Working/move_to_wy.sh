#!/bin/bash

# Set the directory where files are organized by calendar year
SOURCE_DIR="/caldera/hovenweep/projects/usgs/water/impd/hytest/working/niwaa_wrfhydro_monthly_huc12_aggregations/subset_LDASOUT_hr"

echo "Beginning of loop"

# Record the start time
START_TIME=$(date +%s)

# Loop through each calendar year folder in SOURCE_DIR
for year_dir in "$SOURCE_DIR"/*/; do
    # Get the calendar year from the folder name
    calendar_year=$(basename "$year_dir")
    
    # Loop through each file in the calendar year folder
    for file in "$year_dir"*; do
        # Skip if it's not a file
        [[ -f "$file" ]] || continue

        # Extract the date from the filename (assuming format YYYYMMDD)
        filename=$(basename "$file")
        file_date="${filename:0:8}"  # First 8 characters are YYYYMMDD
        
        # Parse year, month, and day
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
        target_year_dir="$SOURCE_DIR/WY$water_year"
        mkdir -p "$target_year_dir"

        # Add "WY" prefix and copy the file to the water year folder
        cp "$file" "$target_year_dir/WY$filename"
    done
done

echo "Files have been copied and pasted with WY prefixes into folders organized by water year."

# Record the end time
END_TIME=$(date +%s)

# Calculate and print the elapsed time
ELAPSED_TIME=$((END_TIME - START_TIME))
echo "Script execution time: ${ELAPSED_TIME} seconds"