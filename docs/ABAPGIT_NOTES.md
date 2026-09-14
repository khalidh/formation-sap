# Notes abapGit

Ce depot fournit le code ABAP textuel complet.

## Points de vigilance

- Les objets non textuels (Dynpro, GUI Status, GUI Titles, transaction, certains DDIC) peuvent dependre de la version abapGit et SAP_BASIS pour leur serialisation XML exacte.
- Pour un import 100% fiable: utiliser ce depot pour le code puis appliquer la creation guidee via `docs/INSTALL_SAP_GUI.md`.

## Strategie recommandee

1. Import des programmes ABAP via abapGit
2. Creation/verification des objets non textuels en SAP GUI
3. Activation globale
4. Execution des tests de `docs/TEST_PLAN.md`
