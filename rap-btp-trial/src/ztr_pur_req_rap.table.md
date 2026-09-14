# Root persistence table specification

Table name: `ZTR_PUR_REQ_RAP`

## Fields

- `MANDT` - client, key
- `REQUEST_ID` - business identifier and root key, CHAR10, unique
- `REQUEST_DATE` - date of request, DATS
- `REQUESTER` - requester, SYUNAME/CHAR12
- `DEPARTMENT` - department, CHAR20
- `DESCRIPTION` - description, CHAR255
- `QUANTITY` - quantity, QUAN 13,3, unit reference `UNIT`
- `UNIT` - unit, UNIT 3
- `UNIT_PRICE` - unit price, CURR 13,2, currency reference `CURRENCY`
- `CURRENCY` - currency, CUKY 5
- `TOTAL_AMOUNT` - total amount, CURR 15,2, currency reference `CURRENCY`
- `STATUS` - business status, domain `ZTR_D_STATUS`
- `CREATED_BY` - created by, SYUNAME
- `CREATED_AT` - created at, DATS/TIMS or UTC timestamp, depending on your ABAP Cloud release
- `CHANGED_BY` - changed by, SYUNAME
- `CHANGED_AT` - changed at, DATS/TIMS or UTC timestamp
- `DEL_FLAG` - logical deletion flag, CHAR1

## Business rules

- `REQUEST_ID` is user-maintained and unique.
- `REQUEST_ID` is the root key in the shared trial variant.
- `TOTAL_AMOUNT = QUANTITY * UNIT_PRICE`.
- `DEL_FLAG = 'X'` excludes a request from the normal list report.
