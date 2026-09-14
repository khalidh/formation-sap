# Installation in SAP BTP ABAP Environment

## Prerequisite

This project requires an ABAP Environment tenant. A generic SAP BTP trial without ABAP Environment cannot execute the RAP backend.
If your trial exposes ABAP Environment in shared mode, you can execute this RAP backend there.

## Order of creation in ADT

1. Package
2. Database table `ZTR_PUR_REQ_RAP`
3. Interface view entity `ZI_TR_PUR_REQ`
4. Consumption view entity `ZC_TR_PUR_REQ`
5. Behavior definition `ZI_TR_PUR_REQ`
6. Behavior projection `ZC_TR_PUR_REQ`
7. Behavior pool class `ZBP_I_TR_PUR_REQ`
8. Service definition `ZUI_TR_PUR_REQ_SRV`
9. Service binding
10. Fiori elements app generation

## Manual UI generation

After the service binding is active, use SAP Fiori tools to generate a List Report / Object Page application.

## Checks

- Validate the `RequestID` root key strategy used in the shared trial variant.
- Ensure `TotalAmount` is read-only in the UI.
- Ensure delete confirmation is enabled in the Fiori elements app.
- Ensure search filters match the business fields.
