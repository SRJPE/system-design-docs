# Standard Operating Procedure for the Central Valley Spring Run Chinook Salmon Juvenile Production Estimate (SR JPE SOP)
*written by Ashley Vizek, updated April 6, 2026*

The SR JPE will ultimately be fully transparent through open and reproducible model code and data that is updated weekly. The SR JPE will be updated on a regular basis throughout the water year as more data become available thus reducing uncertainty in JPE estimates. This document describes the seasonal workflow for updating data and running models to produce the SR JPE. 

The first SR JPE will be produced for water year 2027. The long term and stable infrastructure that will be used to produce the SR JPE on a regular basis is still undergoing active development (as of April 2026) and is expected to continue throughout 2026. This does not prevent the development of a SR JPE. It means that there will be two workflows - (1) the **near-term workflow** meets the immediate need of producing a 2027 SR JPE and to publish manuscripts related to the SR JPE model, (2) the **regular SR JPE workflow** describes the ultimate step-by-step process that will be used to produce SR JPE on a regular and automated schedule into the future.

**Key Resources**
- SRJPE GitHub Organization
- SR JPE Data Management Plan
- SRJPEdata R package
- SRJPEmodel R package

## Near-Term Workflow

There are four submodels in the SR JPE - BTSPAS-X, survival, PLAD, and stock recruit - all of which come together in the integrated SR JPE model. The SR JPE model suite underwent peer-review in the winter of 2026, and models are currently undergoing active development and modifications. Modelers are also working to draft manuscripts for publication. In the background data scientists at FlowWest are working to functionalize model code and develop a data and model system that can be updated on a regular automated schedule. This full system (described in the "regular SR JPE workflow" section) may not be fully functional by January 2027, and we do not want it to get in the way of more immediate needs which is why we developed the "near-term workflow." The main differences between these two workflows are that model code is not fully functionalized in SRJPEmodel, data objects may not be fully available in SRJPEdata, the procedure for running regular automated updates is not defined, and the "near-term workflow" prioritizes code and data publication for manuscripts.

### Overview

The goals for this workflow are (1) store, version, document, and make data and code open and transparent for the 2027 SR JPE, (2) organize code and data in preparation for publication in scientific journals, (3) enable a nimble workflow while components of the regular SR JPE system are being developed.

All code related to the SR JPE is stored and versioned on GitHub in the SR JPE Organization. To meet the needs of this workflow, there is a repository for each model (btspasx, survival, plad, stockrecruit, integratedjpe) with the following file structure:

TODO review and discuss this structure
- README.md: Explains what the code does and how to set up the environment as well as instructions to reproduce the paper's results
- LICENSE: License that specifies how others can use this work. Using
- scripts: Scripts to run models, pull and prepare data, generate results figures and tables
- data: Includes raw data files or if data files are too large where to access
- results: Output figures and tables

Before publication we will integrate [Zenodo](https://zenodo.org/) to generate a DOI for the repositories: 

1. Update data and data checks (RST and associated rulesets, acoustic telemetry for survival, adult data) - April-May


2. PLAD

?

3. BTSPAS-X

List from Josh -

I think these are done:
- Do runs for Feather LFC. Requires code in BT-SPAS-X project to generate all run and spring run weekly estimates for a site called. Requires grabbing data from different trapping sites across years (eye, steep, gateway). This code would document what RST site was used for each year to create Feath_LFS_yyyy.Rdata.
- Get PLAD results for eye riffle to do above
- Run model for missing KL years (2003-2006). Copy PLAD results from any other KL year and rename to these years.
- Copy PLAD results from any hallwood year to years with no PLAD estimates owing to a data naming mixup (Yuba/Hallwood).

Not done:
- Estimate abundance at other mainstem trapping sites. Lower Feather and Delta Entry for sure, and maybe RBDD.
- Consider a BT-SPAS-X redesign (depending on independent review) where we ditch the across-site hierarchy, and estimate at the site-level, but jointly estimati all years from the site, and jointly estimate capture probability model and abundance parameters.
- One of reasons for above approach is to estimate a flow effect on weekly abundances  (i.e., a fixed effect other than b-splile). Multi-year joint analysis almost certainly needed to estimate the flow effect. A big lift. Maybe before jumping into this big task, look at the number of missing weeks resulting from high flows. Perhaps not a big enough issue to pursue.

4. Survival and travel time

From Josh:

Done:
- Work with Ashley to get CWT release data into srJPEdata.

Not done or in progress:
- Add code to JPE model project that predicts weekly abundance of hatchery fish to Sac (the hatchery model).
- Work with Flora to compare abundance and timing of hatchery fish at downstream locations (HFC, lower Feather?) Also compare predictions with existing CWT analysis results (Jason et al.), or get that data if we need to for more specific comparisons.
- Work with Flora to revise survival/TT model to make predictions for Tisdale and Knights Landing for JPE vs. observed outmigrant abundance and timing at these two traps (almost complete). 

5. Stock recruit

From Josh:
- With annual outmigrant estimates from Feath_LFC series (see above), fit models and add to covariate analysis for other sites. 
- Refit stock-recruitment models from other sites because input data has changed and new data has been added (e.g., run model on most recent set of tributary BT-SPAS-X/PLAD output).

6. Within season

- Add-in Feather (natural) component using Feath_LFC series
- Update model for all sites based on most recent BT-SPAS-X/PLAD outmigrant estimates
- Evaluate alternate covariates on median run date (only one evaluated to date) and run steepness (none were evaluated.

7. Model testing

- Add code to use Tis and KL-specific survival and travel time predictions from revised mainstem/TT model (new scripts named DS_Surv_TK and Arrival_Timing_TK.R)
- Update JPE vs observed Tis/KL timing comparison, and do something similar for abundances. The former would be new. This would compare observed historical average annual spring run outmigrant abundance at Tis/KL with predictions from JPE (tributaries + downstream survival). The problem here is apples-oranges comparison among years (same issue for timing comparison).
- Thus, for both timing and abundance JPE vs Tis/KL, do the analysis by year. Find years with outmigrant abundance at ucc, ubc, mill, deer, and at Tis or KL. Route the observed RST abundance to mainstem trap sites, and compare with observations of abundance and timing in that year. Should we use the release group deviates for the year being compared for mainstem model?
- If you establish a good correspondence based on year-specific analysis, then make a forecast for that year and repeat the comparison.


8. Integrated JPE


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
