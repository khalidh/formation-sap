# Node runner for open-abap + abap2UI5

This project is a separate Node.js harness to execute ABAP business logic outside SAP and lint abap2UI5 classes.

## Important scope note

- The original app is a classic Dynpro Module Pool (`SAPMZTR_PUR_REQ`).
- Dynpro screens, PBO/PAI, GUI status/title handling, SAP enqueue server behavior and Open SQL DB access are SAP runtime features and cannot run natively in Node.
- This harness executes extracted business logic only (validation and total calculation) and validates abap2UI5 source statically.

## Quick start

```bash
npm install
npm run openabap:run
npm run abap2ui5:lint
```

The open-abap runtime path in this project executes with Node 20 via `npx node@20`.
This avoids runtime issues seen with some newer Node versions.

## Folders

- `abap/src`: ABAP sources for Node execution via open-abap transpiler/runtime
- `abap2ui5/src`: ABAP class samples for abap2UI5 linter
- `scripts`: Node scripts

## Mapping from ECC app to Node harness

- `calculate_total` FORM -> method `CALCULATE_TOTAL`
- `validate_request_data` FORM -> method `VALIDATE`
- status guard (CLOSED non modifiable) -> method `CAN_BE_CHANGED`

## Why this is an extracted logic runner

The original ECC code is a Dynpro Module Pool.
Dynpro flow logic, GUI status/title handling, SAP enqueue server behavior and Open SQL against SAP tables are SAP kernel features.
They are not directly executable in plain Node.js.

So this project executes the reusable business rules (validation + totals + status guard) in Node via open-abap,
and uses abap2UI5 tooling for class/view validation workflows.

## Expected output

`npm run openabap:run` executes a smoke test report and prints `OPEN_ABAP_SMOKE_TEST_OK` on success.
