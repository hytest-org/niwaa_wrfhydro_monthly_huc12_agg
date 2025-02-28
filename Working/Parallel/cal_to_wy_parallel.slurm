#!/bin/bash
############################################################################
# Parallelized slurm file to move files organized by calendar year into new folders organized by water year.
#                
# Usage: Call shell script using associated slurm file
#    e.g sbatch -o 
# Developed: 1/25/25, L. Staub
# Updated: 1/25/2025, L. Staub
############################################################################

############################################################################

#SBATCH -p cpu  			  # set partition
#SBATCH -A impd 		  	  # set account
#SBATCH --job-name=cal_to_wy              # Job name
#SBATCH --nodes=1                         # Number of nodes (adjust as needed)
#SBATCH --ntasks=9                        # Number of tasks (one task per node/year)
#SBATCH --cpus-per-task=1                 # CPUs per task (adjust as needed)
#SBATCH --time=05:00:00                   # Time limit (adjust as needed)
#SBATCH --output=logs/process_%j.out      # Standard output log
#SBATCH --error=logs/process_%j.err       # Standard error log
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lstaub@usgs.gov       # enter email
#SBATCH -o /caldera/hovenweep/projects/usgs/water/impd/hytest/working/niwaa_wrfhydro_monthly_huc12_aggregations/niwaa_wrfhydro_monthly_huc12_agg/Parallel/output     # set path for job output files to be saved

# Set the source directory containing year folders
SOURCE_DIR="/caldera/hovenweep/projects/usgs/water/impd/hytest/working/niwaa_wrfhydro_monthly_huc12_aggregations/subset_CHRTOUT_hr"


# Record the start time
global_start=$(date +%s)
echo "Job started at $(date)"

# Get a list of year directories
YEAR_DIRS=($(ls -d "$SOURCE_DIR"/*/))
TOTAL_YEARS=${#YEAR_DIRS[@]}

# Ensure the number of tasks matches the number of year directories
if [ "$TOTAL_YEARS" -lt "$SLURM_NTASKS" ]; then
    echo "Fewer years ($TOTAL_YEARS) than tasks ($SLURM_NTASKS). Adjusting tasks."
    SLURM_NTASKS=$TOTAL_YEARS
fi

# Distribute tasks across nodes
for i in $(seq 0 $((SLURM_NTASKS - 1))); do
    if [[ $i -lt $TOTAL_YEARS ]]; then
        # Assign one year directory to each task
        YEAR_DIR=${YEAR_DIRS[$i]}
        echo "Assigning task $i to process files in $YEAR_DIR"

        # Run the processing script for the year directory
        srun --ntasks=1 --exclusive ./cal_to_wy_parallel.sh "$YEAR_DIR" &
    fi
done

# Wait for all tasks to complete
wait

# Record the end time
global_end=$(date +%s)
global_elapsed=$((global_end - global_start))
echo "Job finished at $(date)"
echo "Total job runtime: $global_elapsed seconds."

sbatch /caldera/hovenweep/projects/usgs/water/impd/hytest/working/niwaa_wrfhydro_monthly_huc12_aggregations/niwaa_wrfhydro_monthly_huc12_agg/Parallel/cal_to_wy_parallel.sh 