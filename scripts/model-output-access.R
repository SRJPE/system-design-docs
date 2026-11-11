# Google Drive push/pull script
# Purpose: Model output files are often too large to store in GitHub alongside
# model code and are instead stored remotely on Google Drive. These files need
# to be accessed to extract and share results. The primary workflow is:
# run model -> push fit to GDrive -> extract results needed and save as CSV in GitHub repository
# This is an example script that can be used within the runSRJPE workflow

# install.packages("googledrive")

library(googledrive)

# ---- Connect -----------------------------------------------------------------
# First run opens a browser to sign in; the token is cached for later sessions.
# Pass email = "you@example.com" to skip the account picker.

drive_auth()

# Source helper functions
source("model-output-storage-helpers.R") # adjust filepath as needed

# ---- Examples ----------------------------------------------------------------
# List all files within a folder
gd_list("jpe-model-output-storage/test/0.0.0/btspasx")

# Read in one RDS file. It is OK if the file name has spaces in it
test_model_output <- gd_read_rds(
  "jpe-model-output-storage/test/0.0.0/btspasx/butte creek_2001.rds"
)

# Read in all RDS from a folder and save locally into a folder
gd_pull_rds_folder("jpe-model-output-storage/test/0.0.0/btspasx", "models/2027")

# Read in all RDS from a folder and then access by fit object
fits <- gd_read_rds_folder("jpe-model-output-storage/test/0.0.0/btspasx")
names(fits) # file names without .rds
fits$`butte creek_2006` # access one

# Push one file
gd_write_rds(fits, "jpe-model-output-storage/test/testfit.rds")
