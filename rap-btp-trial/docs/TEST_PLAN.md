# Test plan for RAP

| ID | Prerequisite | Action | Data | Expected result |
|---|---|---|---|---|
| T01 | App open | Create request | Valid RequestID + mandatory fields | Record created |
| T02 | Existing RequestID | Recreate same business ID | Same RequestID | Duplicate rejected |
| T03 | Mandatory field empty | Save create | Missing Requester | Validation error |
| T04 | Quantity negative | Save create | Quantity = -1 | Validation error |
| T05 | Calculation | Save/modify | Quantity x UnitPrice | TotalAmount updated |
| T06 | Existing record | Display | Valid UUID/ID | Record displayed read-only |
| T07 | Unknown ID | Display | Non-existent RequestID | Not found message |
| T08 | Editable record | Change | Modify description | Update saved |
| T09 | Closed status | Change | Status = CLOSED | Update blocked |
| T10 | Existing record | Delete with confirm | Confirm delete | Logical delete applied |
| T11 | Existing record | Delete cancel | Cancel dialog | No change |
| T12 | Unknown record | Delete | Non-existent ID | Not found message |
| T13 | Multi-criteria filter | Search | Department + date + amount | Filtered list |
| T14 | List row selected | Open object page | Selected row | Object page opens |
| T15 | Two sessions | Concurrent change | Same record | Lock prevents conflict |
| T16 | Audit fields | Create / update | Any valid request | Created/changed fields filled |
| T17 | Navigation | Back / cancel | All pages | Proper navigation |
