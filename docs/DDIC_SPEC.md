# Specification DDIC

## Domaine : ZTR_D_STATUS

- Type : CHAR
- Longueur : 10
- Valeurs autorisees :
  - NEW
  - APPROVED
  - REJECTED
  - CLOSED

## Element de donnees : ZTR_E_STATUS

- Domaine : ZTR_D_STATUS
- Labels:
  - court : Statut
  - moyen : Statut demande
  - long : Statut de la demande d'achat

## Table : ZTR_PUR_REQ

Cle primaire : `MANDT`, `REQUEST_ID`

Champs:

1. `MANDT` (CLNT)
2. `REQUEST_ID` (CHAR10)
3. `REQUEST_DATE` (DATS)
4. `REQUESTER` (CHAR12 / SYUNAME)
5. `DEPARTMENT` (CHAR20)
6. `DESCRIPTION` (CHAR255)
7. `QUANTITY` (QUAN 13,3) ref unite `UNIT`
8. `UNIT` (UNIT 3)
9. `UNIT_PRICE` (CURR 13,2) ref devise `CURRENCY`
10. `CURRENCY` (CUKY 5)
11. `TOTAL_AMOUNT` (CURR 15,2) ref devise `CURRENCY`
12. `STATUS` (ZTR_E_STATUS)
13. `CREATED_BY` (CHAR12 / SYUNAME)
14. `CREATED_AT` (DATS)
15. `CHANGED_BY` (CHAR12 / SYUNAME)
16. `CHANGED_AT` (DATS)
17. `DEL_FLAG` (CHAR1)

## Lock object : EZTR_PUR_REQ

- Table base : ZTR_PUR_REQ
- Cle verrouillee : `MANDT`, `REQUEST_ID`
- FMs generes :
  - `ENQUEUE_EZTR_PUR_REQ`
  - `DEQUEUE_EZTR_PUR_REQ`

## Classe de messages : ZTR_MSG

Messages 001 a 031:

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
