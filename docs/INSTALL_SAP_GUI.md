# Installation controlee dans SAP GUI

Cette procedure garantit la reconstruction complete meme si la serialisation abapGit des objets non textuels varie selon version.

## Ordre de creation

1. Package `ZCRUD_TRAINING` (SE80/SE21)
2. Domaine `ZTR_D_STATUS` (SE11)
3. Element `ZTR_E_STATUS` (SE11)
4. Table `ZTR_PUR_REQ` (SE11)
5. Lock object `EZTR_PUR_REQ` (SE11)
6. Message class `ZTR_MSG` (SE91)
7. Module Pool `SAPMZTR_PUR_REQ` et includes (SE80)
8. Ecrans `0100`, `0200`, `0300` (SE51)
9. GUI Status/Titles `S100/S200/S300`, `T100/T200/T300` (SE41)
10. Transaction `ZPUR_REQ` (SE93)
11. Reports demo `ZTR_PUR_REQ_LOAD_DEMO`, `ZTR_PUR_REQ_CLEAR_DEMO` (SE38)
12. Activation globale et tests

## Parametres cle DDIC

- Cle table : `MANDT + REQUEST_ID`
- Suppression logique : `DEL_FLAG`
- Quantite : QUAN avec reference `UNIT`
- Prix/Montant : CURR avec reference `CURRENCY`

## Checks avant tests

1. FMs lock generes: `ENQUEUE_EZTR_PUR_REQ`, `DEQUEUE_EZTR_PUR_REQ`
2. Ecran 0200 contient un custom control nomme `CC_ALV`
3. Codes fonctions GUI alignes sur PAI
4. Activation sans erreur de syntaxe
