# Draft Design Document: Model Output Storage

*Authors: Ashley Vizek*
*Reviewers: Emanuel Rodriguez, Liz Stebbins*

## Context/Framing

The SRJPE system requires running a suite of Bayesian models, some of which depend on the output of other models. Model output is often too large to retain within the R package used for running model code. We need a protocol for storing, pulling and posting data and metadata from model output.

## Goals

- Develop and implement an efficient system for storing model output that is easily accessible to the SRJPEdata package to process for input into the SRJPEmodel package
- Develop and implement a process for posting model output data
- Create a system that could be automated

## Non-Goals

- Currently we are not trying to retain every model version ever run. We want to store model output that is going to be used
- We do not want to allow anyone to post model output. Posting of model output will be internal but access to stored model output will be public.

## Milestones

## Solutions (include diagram here)

Draft ERD of new database table [here](https://lucid.app/lucidchart/864cfd90-f5e1-4a3b-882a-df95d2571448/edit?invitationId=inv_2aa84121-1586-4805-9840-ba886f140f87&page=OxIKpnFnr11l#)

### Existing Solution

The user works within the SRJPE model package to run the model code. The model output is not being stored anywhere.

### Proposed Solution

- Create a blob storage for the model fit. I do not think that the file name will matter as we will be storing metadata in the SRJPE database. One item to keep in mind is if we want to have a version structure for the filenames or a unique identifier for each file. 

- Add a table to SRJPE database that includes metadata about the model as well as key parameters from the output file and a field that can be used to locate the model fit object that will be stored in blob storage. See the ERD (tab Model Fits). I don't have the whole review process for "approved" model fits worked out so don't think we should complicate it too much now. I decided to structure the table as a long table where there will be multiple rows for each model/site/year/week based on the parameter and statistic. I couldn't think of any tradeoffs of why one way was better so thought longer was cleaner.

- Making model output available in SRJPEdata: We will need to create a pull data script to pull the output data into the SRJPEdata package to make it available. This information will be helpful for plotting in the dashboard and for making results available. Most users will not need the full model fit.

- Making model fits available: We need to create a function for a user to connect to the blob storage and access the most up to date fit object. If we make the file name useful we won't have to connect to the database first and can just pull directly from the blob. The users here will be FlowWest when we run the models or modelers like Josh. Might be easier to make a public blob storage so we don't have to deal with authentication. 

### Alternative Solution

- Store the most recent output in the package. It is not feasible to store the full fit object so would need to just store the tidy table which would lose some information and make versioning slightly more challenging.

## Testing/Monitoring/Alerting

- In mid-July we will work with modelers to ensure the correct information is being stored and can be easily accessed

## Open Questions

## Scoping/Timeline

### Tasks

1. Add new table to database (Emanuel or Inigo)
2. Create blob storage (Emanuel or Inigo)
3. Pull table from database into SRJPEmodel package (Ashley)
4. Write a function for accessing the model fit object in blob storage to be used in the SRJPEmodel package (Emanuel or Liz)
4. Test workflow internally (Liz and Ashley)
5. Test workflow with modelers (Liz and Ashley)

### Timeline

- Week of July 1: Review design doc
- Week of July 8: Add table and blob storage, pull data to SRJPEdata, write function for SRJPEmodel
- Week of July 15: Test internally
- Week of July 22: Test with modelers
