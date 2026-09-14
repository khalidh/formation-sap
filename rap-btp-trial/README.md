# RAP purchase request training project

This folder contains a RAP-based rewrite of the classic Dynpro purchase-request training application.

## Scope

- Managed RAP business object for purchase requests
- Fiori elements service definition and UI annotations
- Business rules mapped from the classic Dynpro app
- Migration and deployment docs for SAP BTP ABAP Environment

## Runtime note

If your BTP trial tenant includes SAP BTP ABAP Environment in shared mode, this project can be executed as a real RAP application.
It is not intended for classic SAP GUI Dynpro and it is not a Node.js runtime project.

If your trial tenant does not expose ABAP Environment, the repository still serves as a portable RAP blueprint and training specification.

## Main objects

- Interface view entity: `ZI_TR_PUR_REQ`
- Consumption view entity: `ZC_TR_PUR_REQ`
- Behavior definition: `ZI_TR_PUR_REQ`
- Behavior projection: `ZC_TR_PUR_REQ`
- Behavior pool class: `ZBP_I_TR_PUR_REQ`
- Service definition: `ZUI_TR_PUR_REQ_SRV`
- Root table specification: `ZTR_PUR_REQ_RAP`

## Design choice

- Technical / business key for the trial variant: `RequestID`
- This keeps the BO simple and aligns with the manual identifier used in the Dynpro version.
- The persistence table still remains RAP-managed and can be exposed through a Fiori elements UI.
