# Corrige formateur

## Bug A - total
Cause: recalcul non systematique avant save.
Correction: recalcul commun avant branche create/update.

## Bug B - verrouillage
Cause: enqueue/dequeue absent ou mal place.
Correction: verrou en entree update/delete, deverrouillage en sortie.

## Bug C - mode affichage
Cause: loop screen incomplet.
Correction: champs metier en input=0 en mode display.

## Bug D - persistance
Cause: gestion transactionnelle incomplete.
Correction: commit sur succes, rollback sur echec.

## Bug E - recherche
Cause: filtre DEL_FLAG manquant.
Correction: exclure DEL_FLAG marque.
