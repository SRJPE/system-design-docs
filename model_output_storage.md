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

- Create a blob storage for the model fit 

- Add a table to SRJPE database that includes metadata about the model as well as key parameters from the output file and a field that can be used to locate the model fit object that will be stored in blob storage.

### Alternative Solution

- Store the most recent output in the package. It is not feasible to store the full fit object so would need to just store the tidy table which would lose some information and make versioning slightly more challenging.

## Testing/Monitoring/Alerting

- In mid-July we will work with modelers to ensure the correct information is being stored and can be easily accessed

## Open Questions

## Scoping/Timeline

### Tasks

1. Add new table to database
2. Create blob storage
3. Write function to connect to the storage and database via the SRJPEmodel package
4. Test workflow internally
5. Test workflow with modelers 

### Timeline

- Week of July 1: Review design doc
- Week of July 8: Add table and blob storage, write function, test internally
- Week of July 15: Test workflow with modelers
