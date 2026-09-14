# Objets non textuels - reference complete

Ce fichier centralise tout ce qui doit etre cree dans SAP GUI/SE80.

## Message class `ZTR_MSG`

001 Ecran reinitialise
002 Identifiant de demande obligatoire
003 Demande chargee en mode affichage
004 Demande chargee en mode modification
005 Demandeur obligatoire
006 Service obligatoire
007 Description obligatoire
008 Quantite doit etre strictement positive
009 Prix unitaire ne peut pas etre negatif
010 Demande cloturee non modifiable
011 Devise obligatoire
012 Suppression annulee
013 Statut invalide
014 Verrouillage impossible
015 Mode courant non enregistrable
016 Demande & inexistante
017 Demande & existe deja
018 Demande & creee avec succes
019 Echec creation demande
020 Demande & modifiee avec succes
021 Echec modification demande
022 Demande & supprimee logiquement
023 Echec suppression logique
024 Demande & verrouillee par un autre utilisateur
025 Aucune donnee trouvee
026 Recherche executee
027 Selectionnez une ligne ALV
028 Donnees de demonstration chargees
029 Echec chargement donnees de demonstration
030 Donnees de demonstration supprimees
031 Aucune donnee de demonstration a supprimer

## GUI Status

### S100
NEW, SEARCH, DISPLAY, CHANGE, SAVE, DELETE, CLEAR, BACK, EXIT, CANCEL

### S200
EXEC_SRCH, RESET_SRCH, OPEN_REQ, BACK, CANCEL

### S300
YES, NO, CANCEL

## GUI Titles

- T100: Demande achat interne - &
- T200: Recherche des demandes
- T300: Confirmation suppression

## Dynpro flow logic

### Screen 0100
```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0100.
  MODULE modify_screen_0100.

PROCESS AFTER INPUT.
  MODULE user_command_0100.
```

### Screen 0200
```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0200.
  MODULE prepare_alv_0200.

PROCESS AFTER INPUT.
  MODULE user_command_0200.
```

### Screen 0300
```abap
PROCESS BEFORE OUTPUT.
  MODULE status_0300.

PROCESS AFTER INPUT.
  MODULE user_command_0300.
```

## Transaction

- Code transaction: `ZPUR_REQ`
- Type: programme + ecran
- Programme: `SAPMZTR_PUR_REQ`
- Ecran initial: `0100`
