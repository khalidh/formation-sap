# Migration from classic Dynpro

## Mapping

| Dynpro concept | RAP equivalent |
|---|---|
| Screen 0100 | Object Page / List Report pages |
| Screen 0200 | List Report filter bar + table |
| Screen 0300 | Delete confirmation dialog in Fiori elements |
| PBO / PAI | RAP framework events + UI annotations |
| FORM calculate_total | Determination `calculateTotal` |
| FORM validate_request_data | Validation methods on save |
| Enqueue/Dequeue | RAP locking / lock master |
| GUI status / titles | Fiori elements shell and annotations |
| classic Open SQL report logic | CDS + behavior implementation |

## Recommended RAP rule set

- Use a UUID technical key.
- Keep `RequestID` as the business-visible identifier.
- Hide technical fields from the UI.
- Expose audit fields as read-only.
- Keep deletion logical.

## Why this differs from Dynpro

Dynpro is UI-driven and SAP GUI-specific.
RAP is service-driven and optimized for OData/Fiori elements.
