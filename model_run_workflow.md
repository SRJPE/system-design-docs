# SR JPE Model Run Workflow

This document outlines a potential workflow for producing SR JPE model output.

**This is a working draft and has not been reviewed or approved**

## Information Needs

This document makes some assumptions about these questions but we need to get answers/agreement on these.

* When do we want to run stock recruit based JPE?
* When (and how often) do we want to run within season JPE models?
* Do we want to update model fits as more data become available?

## Workflow Steps

### End of the outmigration season (June-July)

1. Update data in SRJPEdata package

All data sources that are pulled in and integrated within this R package are updated regularly. The main goal of the SRJPEdata package is to make data available for SR JPE modeling and so the data only need to be updated when they are needed for modeling. A longer-term goal would be to set up automated updates to keep the SRJPEdata package as up to date as possible.

(insert scripts that need to be run)

2. Update model fits

At the end of the monitoring season a new year of RST catch, genetics, and survival data will be available to use to fit SR JPE submodels. The following model fits can be updated with the new data:

* BTSPAS-X
* P2S
* Survival
* PLAD

(insert scripts/functions that need to be run which includes code to save model fits to appropriate data store)

3. Review model fits

After model fits have been updated with new data, these model fits need to be reviewed by the designated lead for the particular model. Over time it is expected that this step will become less important as the models will get better and unique data that requires special priors or specifications will become less frequent (as we will now be familiar with most unique cases). It is recommended that for the first three years of producing SR JPE output, model fits should be reviewed with designated leads. In the future this process will become automated.

The current designated model leads are listed below:

* BTSPAS-X: Josh Korman
* Stock recruit: Josh Korman
* Within season: Josh Korman
* Survival: Flora Cordoleani
* PLAD: Noble Hendrix

FlowWest will provide model leads with updated model fits to review within two weeks. 

4. Iterative updates until model fit is approved

Based on the review process the model fit will be categorized as "approved" or "not approved" and this status will be recorded with the model fit in the data store to keep track of model fit versioning and status. 

FlowWest will work with the model lead to update the model until the model fit is "approved".

### End of adult upstream migration/spawning season (December-January)

1. Update adult EDI packages

Unlike RST EDI packages, adult packages only need to be updated annually and are therefore there is not an automated pipeline for updates. FlowWest has drafted data update protocols for each of the EDI packages and will work with the Data Stewards to update the package as soon as possible December 1-15.

2. Update SR JPE model database

ETL procedures to download adult data from EDI and update the SR JPE model database need to be run after the EDI packages are updated.

3. Update SRJPEdata package

After the database has been updated these data can be pulled into SRJPEdata and prepared for modeling.

(insert scripts to run)

4. Update relevant models

At the end of the adult upstream migration and spawning season, new data will be available to update model fits. Currently this includes the following models:

* P2S

5. Review model fits

After model fits have been updated with new data, these model fits need to be reviewed by the designated lead for the particular model. Over time it is expected that this step will become less important as the models will get better and unique data that requires special priors or specifications will become less frequent (as we will now be familiar with most unique cases). It is recommended that for the first three years of producing SR JPE output, model fits should be reviewed with designated leads. In the future this process will become automated.

The current designated model leads are listed below:

* P2S: Liz Stebbins

6. Run the stock recruit based SR JPE forecast

After all data and submodels have been updated, the SR JPE early forecast (based on stock recruit modeling) can be run

(insert scripts to run, includes saving model output)

7. Review SR JPE early forecast

Similar to the model fit review step, the forecast results should be reviewed with the lead modeler (Josh Korman). Over time this step may become more automated as the models and workflow are improved and stable.

8. Iterative updates until results are approved

Based on the review process the model results will be categorized as "approved" or "not approved" and this status will be recorded with the model fit in the data store to keep track of model fit versioning and status. 

FlowWest will work with the model lead to update the model until the model fit is "approved".

### Within the juvenile outmigration season (February-March)

1. Update data in SRJPEdata package

All data sources that are pulled in and integrated within this R package are updated regularly. The main goal of the SRJPEdata package is to make data available for SR JPE modeling and so the data only need to be updated when they are needed for modeling. A longer-term goal would be to set up automated updates to keep the SRJPEdata package as up to date as possible.

(insert scripts that need to be run)

2. Run the within season based SR JPE forecast

The SR JPE within season forecast can be run with the most up to date RST data.

(insert scripts to run, includes saving model output)

7. Review SR JPE within season forecast

Similar to the model fit review step, the forecast results should be reviewed with the lead modeler (Josh Korman). Over time this step may become more automated as the models and workflow are improved and stable.

8. Iterative updates until results are approved

Based on the review process the model results will be categorized as "approved" or "not approved" and this status will be recorded with the model fit in the data store to keep track of model fit versioning and status. 

FlowWest will work with the model lead to update the model until the model fit is "approved".

### Within the juvenile outmigration season (April-May)

The above steps will be repeated again in April.

