# ZCRUD Training - SAP ECC / RAP / Node

Ce repertoire contient une solution pedagogique complete autour d'une demande d'achat, declinee en trois volets:

1. `src-dynpro/` - version SAP ECC classique en ABAP Dynpro
2. `rap-btp-trial/` - version RAP cible SAP BTP ABAP Environment
3. `node-openabap-abap2ui5/` - harness Node.js pour logique ABAP et vues UI5 de demonstration

## Contenu

- `src-dynpro/` : code ABAP (Module Pool + includes + reports demo)
- `rap-btp-trial/` : sources RAP, CDS, comportement et documentation BTP
- `node-openabap-abap2ui5/` : execution Node open-abap, linter abap2UI5 et captures de demo
- `docs/INSTALL_SAP_GUI.md` : procedure exhaustive de creation dans SAP GUI
- `docs/ARCHITECTURE.md` : architecture fonctionnelle et technique
- `docs/DDIC_SPEC.md` : specification DDIC (domaine, element, table, lock)
- `docs/DYNPRO_SPEC.md` : definition ecrans, flow logic, GUI status/titles
- `docs/TEST_PLAN.md` : plan de test obligatoire (17 cas)
- `docs/USER_MANUAL.md` : manuel utilisateur final
- `docs/SOP.md` : procedure SOP entreprise
- `docs/trainer-kit/` : supports formateur (enonce, corrige, evaluation)

## Noms techniques

- Package : `ZCRUD_TRAINING`
- Table : `ZTR_PUR_REQ`
- Domaine statut : `ZTR_D_STATUS`
- Element statut : `ZTR_E_STATUS`
- Classe messages : `ZTR_MSG`
- Lock object : `EZTR_PUR_REQ`
- Module Pool : `SAPMZTR_PUR_REQ`
- Includes : `MZTR_PUR_REQ_TOP`, `MZTR_PUR_REQ_O01`, `MZTR_PUR_REQ_I01`, `MZTR_PUR_REQ_F01`
- Transaction : `ZPUR_REQ`
- Ecrans : `0100`, `0200`, `0300`

## Hypotheses

- Cible : SAP ECC 6.0 EHP7/EHP8
- Syntaxe ABAP classique compatible NetWeaver ancien
- ALV : `CL_GUI_ALV_GRID` disponible

## Volets annexes

- `rap-btp-trial/README.md` documente le passage en RAP
- `node-openabap-abap2ui5/README.md` documente l'execution Node et les rendus UI5

## Important (abapGit)

Le code ABAP textuel est fourni directement.

Pour certains objets non textuels (Dynpro, GUI Status, GUI Titles, transaction et certains DDIC), la serialisation XML exacte depend de la version abapGit et SAP_BASIS.

Utiliser `docs/INSTALL_SAP_GUI.md` pour une reconstruction garantie 100% dans le systeme cible.
