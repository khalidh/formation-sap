# Plan de test (obligatoire)

| ID | Prerequis | Action | Donnees | Resultat attendu |
|---|---|---|---|---|
| T01 | Application ouverte | Creation valide | REQ1000001 + champs obligatoires | Message succes creation |
| T02 | REQ1000001 existe | Re-creation meme ID | REQUEST_ID=REQ1000001 | Erreur doublon |
| T03 | Mode creation | Champ obligatoire vide | REQUESTER vide | Erreur validation |
| T04 | Mode creation | Quantite negative | QUANTITY=-1 | Erreur validation |
| T05 | Mode creation | Calcul montant | QTE=3, PRIX=99.50 | TOTAL=298.50 |
| T06 | REQ existante | Afficher | ID valide | Chargement mode affichage |
| T07 | REQ absente | Afficher inexistante | ID inconnu | Message inexistante |
| T08 | REQ non closee | Modifier valide | Changer description | Message succes modification |
| T09 | REQ status CLOSED | Tenter modifier | ID CLOSED | Refus modification |
| T10 | REQ existante | Supprimer confirmee | DELETE + YES | Suppression logique |
| T11 | REQ existante | Supprimer annulee | DELETE + NO | Aucune suppression |
| T12 | REQ absente | Supprimer inexistante | ID inconnu | Message inexistante |
| T13 | Donnees multiples | Recherche multicritere | Dept + dates + montant | Resultats filtres |
| T14 | Resultats ALV | Ouvrir depuis ALV | Selection ligne | Retour ecran 0100 |
| T15 | 2 sessions SAP GUI | Test verrouillage | Meme REQUEST_ID | Seconde session bloquee |
| T16 | Creation + modif | Verif audit | CREATED/CHANGED | Champs audit corrects |
| T17 | Navigation | BACK/EXIT/CANCEL | Tous ecrans | Sortie conforme |
