# Standard Operating Procedure for the Central Valley Spring Run Chinook Salmon Juvenile Production Estimate (SR JPE SOP)
*written by Ashley Vizek, updated April 6, 2026*

The SR JPE is a suite of interactive models for forecasting and hindcasting the abundance and timing of juvenile spring-run Chinook Salmon entering the Sacramento-San Joaquin Delta from the Sacramento River watershed. This document describes the seasonal workflow for updating data and running models to produce the SR JPE, and the process for updating the models [we can make this separate doc if too jumbled to put in this one]. The SR JPE will ultimately be fully transparent through open and reproducible model code and data that is updated weekly. The SR JPE will be updated on a regular basis throughout the water year as more data become available with the goal of reducing uncertainty in JPE estimates. 

The first SR JPE will be produced for water year 2027 expected to be available January 2027. The long term and stable infrastructure that will be used to produce the SR JPE on a regular basis is still undergoing active development (as of April 2026) and is expected to continue throughout 2026. This does not prevent the development of a SR JPE. It means that there will be three workflows - (1) the **near-term workflow** meets the immediate need of producing a 2027 SR JPE and needs around manuscript publication related to the SR JPE models, (2) the **regular SR JPE workflow** describes the ultimate step-by-step routine that will be used to produce an SR JPE on a regular annual and automated schedule into the future, (3) the third **SRJPE model update workflow** describes model update processes that will occur at annual to multi-year frequencies [we can add this info from Ch 1,2,3 of IPR package]. The near-term workflow will include detailed step-by-step instructions and the guide for the regular workflow will continue to be built out

**Key Resources**
- (SRJPE GitHub Organization)[https://github.com/SRJPE] is where all code is stored, versioned and made accessible
- (SR JPE Data Management Plan)[https://github.com/SRJPE/system-design-docs/blob/main/srjpe_data_management_plan.md] a working document that describes data sources and products as well as the full data and model system for the SR JPE. The SOP is a companion document. The DMP documents the full data lifecycle whereas the SOP is focused on the instructions for producing and updating a SR JPE.
- (SRJPEdata R package)[https://github.com/SRJPE/SRJPEdata] R data package for data inputs to SR JPE models. This has been in active development alongside model code as new data needs arise. Ultimately this package will include tagged releases and DOI associated with manuscript publication and SR JPE estimates.
- (SRJPEmodel R package)[https://github.com/SRJPE/SRJPEmodel] R package with functions for running models. This package is in active development and not all models are included yet. This will continue to be developed as model code stabilizes.

## Near-Term Workflow

There are five submodels in the SR JPE - BTSPAS-X, survival (and travel time), PLAD, stock recruit, and within season outmigrant - all of which come together in the integrated SR JPE model. The SR JPE model suite underwent peer-review in the winter of 2026, and models are currently undergoing active development and modifications. Modelers are also working to draft manuscripts for publication. In the background data scientists at FlowWest are working to functionalize model code and develop a data and model system that can be updated on a regular automated schedule. This full system (described in the "regular SR JPE workflow" section) may not be fully functional by January 2027, and we do not want it to get in the way of more immediate needs which is why we developed the near-term workflow. The main differences between these two workflows are that model code is not fully functionalized in SRJPEmodel, data objects may not be fully available in SRJPEdata, the procedure for running regular automated updates is not defined, and the near-term workflow prioritizes code and data publication for manuscripts.

### Overview

The goals for this workflow are (1) store, version, document, and make data and code open and transparent for the 2027 SR JPE, (2) organize code and data in preparation for publication in scientific journals, (3) enable a nimble workflow while components of the regular SR JPE system are being developed.

All code related to the SR JPE is stored and versioned on GitHub in the SRJPE Organization. To meet the needs of this workflow, there is a repository for each model (btspasx, survival, plad, stockrecruit, withinseason, integratedjpe) with the following file structure. The (model-code-template)[https://github.com/SRJPE/model-code-template] repository can be used as a template. The template includes .md files with best practices.

TODO review and discuss this structure
- README.md: Explains what the code does and how to set up the environment as well as instructions to reproduce the paper's results
- LICENSE: License that specifies how others can use this work. Using
- scripts: Scripts to run models, pull and prepare data, generate results figures and tables
- data: Includes raw data files or if data files are too large where to access
- results: Output figures and tables

Before publication we will integrate [Zenodo](https://zenodo.org/) to generate a DOI for the repositories and SRJPEdata.

### Ongoing Development

#### 1. Model Updates

Starting January 2026 models (and data) have been undergoing updates and modifications in response to the peer-review and in preparation for manuscript publication resolve lingering issues. Development is expected to continue through June 2026. Please refer to the working list of updates (INSERT LINK TO GOOGLE DOC).

#### 2. Model Code

In addition to the model updates, during this time it is expected that all model code will be uploaded to the respective repository on GitHub (as discussed in the previous section). Ideally, modelers will version their updates; however, at the very least functional, publication-ready code will be available. It is expected that the code will be reproducible and FlowWest will test this by attempting to reproduce results for each model repository. FlowWest will support this process as needed including - implementing package versioning through `renv`, helping document code, providing scripts and workflows to large file and model fit storage, versioning data objects available in SRJPEdata, troubleshooting data issues.

**Expectation: All model code published to respective GitHub repository by end of June 2026.**

#### 3. Testing Model Code

FlowWest will work with modelers to test model code, ensuring that it is reproducible and meets the best practices for publication-ready code. 

**Expectation: All model code will be tested, reproducible, and publication-ready by end of July 2026**

#### 4. Integrated SR JPE

The development of an integrated SR JPE will require a number of decision points including:

- For stock recruit modeling: (1) what if adult data are not available, (2) what covariate is used
- For integrated model: (1) what prior is used if adult data are not available, (2) what forecast covariate is used

FlowWest will work with modelers to find resolution on these decision points and document them here.

**Expectation: The integrated SR JPE will be functional and decision points documented by end of August 2026**

### 2027 SR JPE 

After the period of active development and preparation for manuscript publication concludes in August 2026, preparation for developing the 2027 SR JPE will begin. 

#### 1. Data updates

For the 2027 SR JPE to use the best available information, a number of data need to be updated first.

- RST (including efficiency trials) for BTSPASX (stock recruit and within season depend on this)
- Acoustic telemetry for survival/travel time model
- Flow for BTSPAXX
- Temperature (TBD how this is being used)
- Genetics data for PLAD
- Adult data for the stock recruit

RST, flow, temperature, and adult data are in SRJPEdata. Acoustic telemetry and genetics data are in the process of being in SRJPEdata. The sections below specify how to update each data type. For data in SRJPEdata, running [update_data.R](https://github.com/SRJPE/SRJPEdata/blob/main/data-raw/update_data.R) will update all data in the package.

##### RST

Currently, to update these data run (combine_database_pull_and_save.R)[https://github.com/SRJPE/SRJPEdata/blob/main/data-raw/pull_data_scripts/combine_database_pull_and_save.R]. RST data are regularly pulled from EDI and loaded in the SR JPE model database for storage. These data are integrated with data being collected using DataTackle and stored in the DataTackle database as well as misfit data that need to be pulled directly from EDI. To update the data inputs for the BTSPASX model run (build_rst_model_datasets.R)[https://github.com/SRJPE/SRJPEdata/blob/main/data-raw/process_data_scripts/build_rst_model_datasets.R]

**Expectation: Pull data by June 2026. Implement an automated workflow through GitHub Actions to run this script on a schedule by September 2026. Ensure all data have been updated! This is not critical for 2027 SR JPE but will help with biweekly data and model updates**

##### Acoustic telemetry

Flora has not been relying on SRJPEdata for the acoustic telemetry data for the survival model. If that is still the case in August 2026, work with Flora to ensure data can be updated in the `survival` repository using her data prep code. Ideally, however, we will transition Flora to pulling directly from SRJPEdata for these data. The data prep process is currently in development and should be finished by June.

**Expectation: Pull survival data using SRJPEdata and check this with Flora by June 2026. Implement an automated workflow through GitHub Actions to run this script on a schedule by September 2026. Ensure all data have been updated! This is not critical for 2027 SR JPE but will help with biweekly data and model updates**

##### Flow 

Environmental data (weekly aggregation) are prepared and stored in SRJPEdata. Flow data are used by BTSPASX and summarized flow data are used in the survival model. Currently, to update these data run (pull_environmental_data.R)[https://github.com/SRJPE/SRJPEdata/blob/main/data-raw/pull_data_scripts/pull_environmental_data.R] and (forecast_covariates.Rmd)[https://github.com/SRJPE/SRJPEdata/blob/main/vignettes/forecast_covariates.Rmd] to update the summarized flow values for the survival model. To update the data inputs for the BTSPASX model run (build_rst_model_datasets.R)[https://github.com/SRJPE/SRJPEdata/blob/main/data-raw/process_data_scripts/build_rst_model_datasets.R]

**Expectation: There are gaps in the flow data and this would be a good opportunity to evaluate if better approaches could be used to fill these. This should be completed by end of May 2026 and data updated by June 2026. Implement an automated workflow through GitHub Actions to run this script on a schedule by September 2026. Ensure all data have been updated! This is not critical for 2027 SR JPE but will help with biweekly data and model updates**

##### Genetics data

Genetics data are stored in the runid database. FlowWest has been working the DWR GEM Lab to streamline the data processing and upload process and publish these data on EDI. We have not yet finalized the data structure (primarily the ruleset used for run determination) and have not published the data on EDI. When the data are published on EDI they will be integrated into the SRJPEdata package and updated on a regular basis. We need to develop a script to pull the most recent data from EDI.

**Expectation: By end of June 2026, genetics data are published on EDI, an R script to pull these data into SRJPEdata is developed and tested. Implement an automated workflow through GitHub Actions to run this script on a schedule by September 2026. Ensure all data have been updated! This is not critical for 2027 SR JPE but will help with biweekly data and model updates**

##### Adult data

FlowWest worked with data collectors to publish adult datasets on EDI though due the inconsistent and challenging structure of these datasets was only successful in publishing Yuba River adult passage estimates to EDI. Adult data are used in SR JPE stock recruit modeling and need to be updated ASAP in December-January. Beginning December 1 FlowWest will email data contacts (see below) to prepare for this data need and include the expected data type and structure. TODO INSERT MORE DETAILS HERE. The (pull_adult_data.R)[https://github.com/SRJPE/SRJPEdata/blob/main/data-raw/pull_data_scripts/pull_adult_data.R] will need to be updated and then run to update SRJPEdata. In some cases, like for the Yuba River, adult data may not be available in time for the SR JPE stock recruit.

**Expectation: Data outreach for SR JPE adult data begins December 2026 and data are integrated by January 1 2026**

#### 2. Model fit updates

##### BTSPASX

TODO insert links when available

This can begin June 2026.

- Pull in updated data by running data prep script (insert link)
- Run BTSPASX (insert instructions on how to do this or refer to readme in the repo)
- QC output (TODO what does the QC process look like)

**Expectation: Model refit and QC by August 2026**

##### Survival and travel time

TODO insert links when available

This can begin June 2026.

- Pull in updated data by running data prep script (insert link)
- Run survival and travel time model (insert instructions on how to do this or refer to readme in the repo)
- QC output (TODO what does the QC process look like)

**Expectation: Model refit and QC by August 2026**

##### PLAD

TODO insert links when available

This can begin June 2026.

- Pull in updated data by running data prep script (insert link)
- Run PLAD (insert instructions on how to do this or refer to readme in the repo)
- QC output (TODO what does the QC process look like)

**Expectation: Model refit and QC by August 2026**

##### Stock recruit

TODO insert links when available

This can begin January 2026.

- Pull in updated data by running data prep script (insert link)
- Run stock recruit (insert instructions on how to do this or refer to readme in the repo)
- QC output (TODO what does the QC process look like)

**Expectation: Model refit and QC by January 15 2026**

##### Within season

TODO insert links when available

This can begin January 15 2026 (? does this need to happen)

- Pull in updated data by running data prep script (insert link)
- Run within season (insert instructions on how to do this or refer to readme in the repo)
- QC output (TODO what does the QC process look like)

**Expectation: Model refit and QC by February 2026**

#### 3. Model run process

TODO outline the steps and insert links when available

- Run monthly beginning in February
- Document decision process of what to use for covariates and what to do if adult data not available
- As new RST and flow data become available does BTSPASX need to be updated?

## Regular SR JPE Workflow

### Overview

| Season | Timing | Key Actions |
|--------|--------|-------------|
| End of outmigration season | June–July | Update SRJPEdata, fit submodels (BTSPAS-X, P2S, Survival, PLAD) |
| End of adult migration/spawning season | December–January | Update adult EDI packages, fit P2S, run stock-recruit JPE forecast |
| Within juvenile outmigration season | February–May | Update SRJPEdata, run within-season JPE forecast |

### Prerequisites

Before running any part of this workflow, confirm the following are in place:

- **SRJPEdata package** — installed and configured in your R environment
- **SRJPEmodel package** — installed and configured in your R environment
- **SR JPE model database** — access to the Azure PostgreSQL instance
- **EDI credentials** — for downloading and publishing EDI data packages
- **Model fit data store** — write access to the storage location for model outputs

---

### Workflow Steps

#### 1. End of outmigration season (June–July)

##### 1.1 Update data in SRJPEdata package

All data sources integrated within the SRJPEdata package are updated regularly. Updates only need to be run when data are needed for modeling. A longer-term goal is to automate updates to keep the package as current as possible.

**Scripts to run:**

A GitHub Action called `update-data` is used to automate data updates (TODO insert link). The Action runs the following scripts on a biweekly schedule.

```r
# TODO: [script/function name] — pulls updated RST catch data into SRJPEdata
# TODO: [script/function name] — pulls updated genetics data into SRJPEdata
# TODO: [script/function name] — pulls updated survival data into SRJPEdata
# TODO script to update the SRJPEdata package
```

##### 1.2 Update model fits (BTSPAS-X, P2S, Survival, PLAD)

At the end of the monitoring season a new year of RST catch, genetics, and survival data is available to refit SR JPE submodels. Each of the following models should be updated:

- **BTSPAS-X** — juvenile abundance and mark-recapture efficiency model
- **Survival** — tributary survival and travel time model
- **PLAD** — probabilistic length at date model

TODO need functions or a workflow to make this step easy in SRJPEmodel

**Scripts to run:**

```r
# TODO: [script/function name] — fits BTSPAS-X model; saves fit to [data store]
# TODO: [script/function name] — fits Survival model; saves fit to [data store]
# TODO: [script/function name] — fits PLAD model; saves fit to [data store]
```

##### 1.3 Review model fits

After model fits are updated, each fit must be reviewed by the designated model lead (see [Model Leads Reference](#model-leads-reference)). For the first three years of SR JPE production, all model fits should be reviewed with designated leads. This process is expected to become more automated over time as models stabilize.

FlowWest will provide model leads with updated fits to review within two weeks of completion.


##### 1.4 Iterative updates until approved

Based on review, each model fit will be categorized as **approved** or **not approved**. This status is recorded with the model fit in the data store for versioning and audit purposes.

FlowWest will work with the model lead to revise and resubmit the model fit until it reaches **approved** status.

---

#### 2. End of adult migration/spawning season (December–January)

##### 2.1 Update adult data and EDI packages

Unlike RST EDI packages, adult data packages are updated annually and do not have an automated pipeline. FlowWest has drafted data update protocols for each adult EDI package and will coordinate with Data Stewards to publish updates between December 1–15.

Insert contact information and data type for each stream. For those on EDI insert the process for EDI updates
- Battle Creek
- Butte Creek
- Clear Creek
- Deer Creek
- Feather River
- Mill Creek
- Yuba River

##### 2.2 Update SRJPEdata package

After the adult EDI packages are updated - or where those do not exist yet data are received from data stewards - the new adult data needs to be integrated into SRJPEdata and prepared for modeling. Additionally all available environmental data being used needs to be integrated.

**Scripts to run:**

```r
# TODO: [script/function name] — pulls updated adult data into SRJPEdata
# TODO: data updates that need to happen in SRJPEdata (do we need to run all vignettes etc)
```

##### 2.3 Run stock-recruit SR JPE forecast

After data are updated, run the early SR JPE forecast using the stock-recruit model.

TODO insert decision tree for if the adult data are not available...

**Scripts to run:**

```r
# TODO: [script/function name] — runs stock-recruit SR JPE forecast; saves output to [data store]
```

##### 2.4 Review SR JPE early forecast

Forecast results must be reviewed by the lead modeler (Josh Korman). This review step is expected to become more automated as the workflow matures.

##### 2.5 Iterative updates until approved

Based on review, forecast results will be categorized as **approved** or **not approved** and recorded in the data store.

FlowWest will work with the model lead to revise results until they reach **approved** status.

---

#### 3. Within juvenile outmigration season (February–May)

##### 3.1 Update data in SRJPEdata package

Pull the most current RST data and any other in-season data sources into SRJPEdata ahead of the forecast run.

**Scripts to run:**

```r
# TODO: [script/function name] — pulls updated in-season RST data into SRJPEdata
```

##### 3.2 Run within-season SR JPE forecast

Run the within-season forecast using the latest available RST data.

**Scripts to run:**

```r
# TODO: [script/function name] — runs within-season SR JPE forecast; saves output to [data store]
```

##### 3.3 Review within-season forecast

Forecast results must be reviewed by the lead modeler (Josh Korman). See [Model Leads Reference](#model-leads-reference).

##### 3.4 Iterative updates until approved

Based on review, forecast results will be categorized as **approved** or **not approved** and recorded in the data store.

FlowWest will work with the model lead to revise results until they reach **approved** status.

---

### Model Leads Reference

| Model | Lead | Organization |
|-------|------|--------------|
| BTSPAS-X | Josh Korman | TODO |
| Stock-recruit | Josh Korman | TODO |
| Within-season | Josh Korman | TODO |
| Survival | Flora Cordoleani | TODO |
| PLAD | Noble Hendrix | TODO |
| P2S | Liz Stebbins | TODO |

### Approval Process

At the end of each review step, model fits and forecast outputs are assigned one of two statuses:

- **Approved** — the model lead has reviewed the output and confirmed it is acceptable for use in SR JPE production.
- **Not approved** — the output requires revision before it can be used.

Status, version, and reviewer information are recorded alongside each model fit or forecast output in the data store. This versioning record provides an audit trail and supports reproducibility across SR JPE production years.
