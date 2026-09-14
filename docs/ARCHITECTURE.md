# Architecture de l'application

## Objectif

Application SAP GUI de gestion de demandes d'achat internes en mode CRUD.

## Architecture Module Pool

- Programme : `SAPMZTR_PUR_REQ`
- Include TOP : donnees globales, constantes, references ALV, modes ecran
- Include O01 : modules PBO
- Include I01 : modules PAI
- Include F01 : sous-programmes FORM reusables

## Ecrans

- `0100` : ecran principal CRUD
- `0200` : recherche multicritere + ALV
- `0300` : confirmation suppression

## Modes de fonctionnement

- `C` : creation
- `D` : affichage
- `U` : modification

## Choix pedagogiques

1. `REQUEST_ID` en saisie manuelle pour simplicite ECC.
2. Suppression logique via `DEL_FLAG` pour tracabilite.
3. Verrouillage enqueue/dequeue pour operations sensibles.
4. Gestion explicite `COMMIT WORK` / `ROLLBACK WORK`.
5. Messages centralises dans `ZTR_MSG`.
