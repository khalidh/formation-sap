# Specification Dynpro

## Ecran 0100 (principal)

Attributs:
- Type : Normal
- Next screen : 0100

Champs principaux:
- `ZTR_PUR_REQ-REQUEST_ID` (group1 `IDN`)
- `ZTR_PUR_REQ-REQUEST_DATE` (group1 `REQ`)
- `ZTR_PUR_REQ-REQUESTER` (group1 `REQ`)
- `ZTR_PUR_REQ-DEPARTMENT` (group1 `REQ`)
- `ZTR_PUR_REQ-DESCRIPTION` (group1 `PUR`)
- `ZTR_PUR_REQ-QUANTITY` (group1 `PUR`)
- `ZTR_PUR_REQ-UNIT` (group1 `PUR`)
- `ZTR_PUR_REQ-UNIT_PRICE` (group1 `PUR`)
- `ZTR_PUR_REQ-CURRENCY` (group1 `PUR`)
- `ZTR_PUR_REQ-TOTAL_AMOUNT` (group1 `AUD`, output)
- `ZTR_PUR_REQ-STATUS` (group1 `PUR`)
- `ZTR_PUR_REQ-CREATED_BY` (group1 `AUD`, output)
- `ZTR_PUR_REQ-CREATED_AT` (group1 `AUD`, output)
- `ZTR_PUR_REQ-CHANGED_BY` (group1 `AUD`, output)
- `ZTR_PUR_REQ-CHANGED_AT` (group1 `AUD`, output)

Flow logic 0100:

```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0100.
  MODULE modify_screen_0100.

PROCESS AFTER INPUT.
  MODULE user_command_0100.
```

## Ecran 0200 (recherche + ALV)

Attributs:
- Type : Normal
- Next screen : 0200

Champs de recherche:
- `GV_S_REQUEST_ID`
- `GV_S_REQUESTER`
- `GV_S_DEPARTMENT`
- `GV_S_DATE_FROM`
- `GV_S_DATE_TO`
- `GV_S_STATUS`
- `GV_S_AMT_MIN`
- `GV_S_AMT_MAX`

Custom control:
- Nom obligatoire : `CC_ALV`

Flow logic 0200:

```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0200.
  MODULE prepare_alv_0200.

PROCESS AFTER INPUT.
  MODULE user_command_0200.
```

## Ecran 0300 (confirmation)

Attributs:
- Type : Modal dialog box
- Next screen : 0300

Flow logic 0300:

```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0300.

PROCESS AFTER INPUT.
  MODULE user_command_0300.
```

## GUI Status

- `S100` : NEW, SEARCH, DISPLAY, CHANGE, SAVE, DELETE, CLEAR, BACK, EXIT, CANCEL
- `S200` : EXEC_SRCH, RESET_SRCH, OPEN_REQ, BACK, CANCEL
- `S300` : YES, NO, CANCEL

## GUI Titles

- `T100` : Demande achat interne - &
- `T200` : Recherche des demandes
- `T300` : Confirmation suppression
