# Architecture RAP

## Functional target

Purchase request management with the same business scope as the Dynpro version:

- create
- display
- change
- delete
- search / filter
- audit fields
- status control
- total amount calculation

## Technical style

Managed RAP business object on a custom persistence table.

## Main layers

1. Persistence table `ZTR_PUR_REQ_RAP`
2. Interface view entity `ZI_TR_PUR_REQ`
3. Consumption view entity `ZC_TR_PUR_REQ`
4. Behavior definition `ZI_TR_PUR_REQ`
5. Behavior projection `ZC_TR_PUR_REQ`
6. Behavior pool class `ZBP_I_TR_PUR_REQ`
7. Service definition `ZUI_TR_PUR_REQ_SRV`
8. Fiori elements app generated from the service binding

## RAP design choices

- Root key `RequestID` keeps the trial variant simple and user-maintained.
- The same business identifier remains visible in the UI and is enforced as unique by the persistence key.
- Determination recalculates `TotalAmount`.
- Validations enforce mandatory fields and business rules.
- Deletion is logical via `DEL_FLAG`.
