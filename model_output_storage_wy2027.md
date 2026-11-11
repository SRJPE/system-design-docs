# Model Output Storage & Versioning

This document describes the model output storage and versioning solution for water year 2027. More permanent solutions are in development and involve blob storage on Azure and access via an API.

## Versioning

We will follow semantic versioning - major.minor.patch. Major will represent a new forecast year whereas minor will represent iterations within that year. Patch will include any bug fixes or updates to an iteration. Versioning will only track published forecasts meaning that results have been shared through the dashboard and a GitHub release of runSRJPE published. Development model runs will not be tracked through versioning.

Water year 2027 will use the beta versioning - 0.0.0. This is the first year the JPE is being produced and should be viewed as a preliminary or beta run. 

- Forecast season 2027 - 0.0.0
- January 2027 - 0.1.0
- February 2027 - 0.2.0
- March 2027 - 0.3.0
- April 2027 - 0.4.0

All model code used to produce the JPE will be tagged as a GitHub release with the appropriate version number. 

Each forecast version will have a number of associated model outputs, and similarly model output will be labeled with the associated version. In some cases, model output will only be produced once for the forecast season in which case it will carry the X.0.0 version number for the given season.

## Storage

For water year 2027, Google Drive will be used as the blob storage solution. 

**Folder structure**

jpe-model-output-storage/

- 0.0.0/survival; 0.0.0/stock-recruit; 0.0.0/plad. Model output used throughout the forecast season.
- 0.1.0/btspasx; 0.1.0/inseason; 0.1.0/jpe. Model output for January 2027
- 0.2.0/btspasx; 0.2.0/inseason; 0.2.0/jpe. Model output for February 2027
- 0.3.0/btspasx; 0.3.0/inseason; 0.3.0/jpe. Model output for March 2027
- 0.4.0/btspasx; 0.4.0/inseason; 0.4.0/jpe. Model output for April 2027

It is assumed that model output files will `.rds` files. Some models like BTSPAS-X may contain many files.

LIZ - Do we need a separate folder for travel-time?

Note that Ashley owns this Google Drive folder through avizek@flowwest.com and access can be granted by contacting Ashley Vizek.

**File naming convention**

date-modelname-modelcomponent-version

- date: mmddyyyy; 11062026
- modelname: btspasx, stockrecruit, survival, traveltime, plad, inseason
- modelcomponent: abundance, pcap...
- version: vxxx; v000 or v010

LIZ - are there other model names needed? are there other model components needed? i was thinking this would make it easier to pull the file needed but if you don't think so then we can get rid of it.

**csv results output**

For convenience, results from the `.rds` files can be extracted and saved as a `.csv` within the GitHub repository. This will only be done after the team has decided only the final model output objects (see workflow section below)

`.csv` output should be saved with the same naming conventions as the `.rds` object so it is clear when the file was created and what version it is associated with. The code owner should maintain the `.csv` files so that there are not multiple copies of the same file in the repository.

This storage option allows easy connection to results output. For instance, the dashboard could rely on `.csv` results output by rather than pull down the `.rds` object and then extracting results as this takes longer to do on the fly. 

*Caution* Use caution here as it would be easy for `.csv` files to become disconnected with the final model output. Where possible, the better workflow would be to pull directly from Google Drive.


## Workflow

**Push**

run model -> push output `.rds` to GDrive

Integrate pushing functions from `model-output-access.R` into model run workflow

runSRJPE was envisioned as the repository to hold all model code related to the JPE use case of running the models. Separate model repositories were set up to facilitate model development and manuscript documentation. 

As models are being run it is possible that they may need to be rerun or mistakes are made during the process. Rather than keeping track of versioning in this development period we will rely on the date string in the file name. Versioning is to keep track of published model output, not output in development.

All model runs (unless they are complete scratch) should be stored on the Google Drive with the date in the file name. When the forecast is being prepared, the team (primarily, Liz, Alex, Ashley, Bill) will go through and move older files to an "archive" folder. For example if there were multiple inseason runs in the inseason folder in 0.1.0, we would create an archive folder (0.1.0/inseason/archive) and move the out of date files there. Only the model output used in the January 2027 forecast for inseason should be stored at the root (0.1.0/inseason)

**Pull**

pull `.rds` output from GDrive -> run dependent model -> refer back to the push workflow

Submodels within the JPE rely on output from other models. The fully reproducible workflow will pull the appropriate `.rds` file from GDrive, extract the results needed into a `.csv` object (stored within GitHub) and then utilize either the `.rds` file or `.csv` file to run the dependent model. Then refer back to the push workflow.

