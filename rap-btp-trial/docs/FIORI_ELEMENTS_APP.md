# Fiori elements app generation

## Goal

Expose the RAP service as a List Report / Object Page application.

## Expected pages

- List Report for searching and filtering purchase requests
- Object Page for creating and editing a request
- Delete confirmation via standard Fiori elements behavior

## Important UI bindings

- `RequestID` as the visible business key
- `RequestDate`, `Requester`, `Department`, `Status` in the list report
- `Description`, `Quantity`, `Unit`, `UnitPrice`, `Currency`, `TotalAmount` on the object page
- audit fields as read-only

## Generated app steps

1. Create the service binding for `ZUI_TR_PUR_REQ_SRV`.
2. Use SAP Fiori tools to generate an app from the bound OData V4 service.
3. Choose List Report / Object Page.
4. Map annotations from `ZC_TR_PUR_REQ`.
5. Test create, edit, delete, search, and filters.
