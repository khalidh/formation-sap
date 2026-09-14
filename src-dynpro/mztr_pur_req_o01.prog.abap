*&---------------------------------------------------------------------*
*&  Include           MZTR_PUR_REQ_O01
*&---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* CONCEPT : PBO - Process Before Output
* Le PBO est execute avant l'affichage de l'ecran.
* Il prepare le statut, le titre, et l'etat des champs.
* Ici, il adapte dynamiquement l'ecran selon le mode CRUD.
* Erreur frequente : oublier d'appeler les modules PBO necessaires.
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* CONCEPT : MODULE ... OUTPUT
* Un MODULE OUTPUT est appele depuis le flow logic PBO d'un ecran.
* Il prepare les elements visuels et les donnees d'affichage.
* Ici, chaque ecran a ses modules OUTPUT dedies.
* Erreur frequente : coder logique metier lourde dans OUTPUT.
*---------------------------------------------------------------------*

MODULE status_0100 OUTPUT.
*---------------------------------------------------------------------*
* CONCEPT : GUI Status
* Le GUI Status definit menus, boutons et codes de fonction.
* Ici, S100 expose les actions CRUD principales.
* Erreur frequente : code fonction ecran absent du status.
*---------------------------------------------------------------------*
  SET PF-STATUS 'S100'.

*---------------------------------------------------------------------*
* CONCEPT : GUI Title
* Le GUI Title affiche un titre dynamique de contexte.
* Ici, le titre varie selon mode creation/affichage/modification.
* Erreur frequente : laisser un titre statique non pedagogique.
*---------------------------------------------------------------------*
  CASE gv_mode.
    WHEN c_mode_create.
      SET TITLEBAR 'T100' WITH 'Creation demande'.
    WHEN c_mode_change.
      SET TITLEBAR 'T100' WITH 'Modification demande'.
    WHEN OTHERS.
      SET TITLEBAR 'T100' WITH 'Affichage demande'.
  ENDCASE.
ENDMODULE.

MODULE modify_screen_0100 OUTPUT.
*---------------------------------------------------------------------*
* CONCEPT : LOOP AT SCREEN
* Cette boucle modifie dynamiquement l'attribut INPUT.
* On l'utilise pour proteger/ouvrir des champs selon le mode ecran.
* Ici, les groupes de modification gerent l'edition selective.
* Erreur frequente : oublier MODIFY SCREEN apres changement.
*---------------------------------------------------------------------*
  LOOP AT SCREEN.
    CASE gv_mode.
      WHEN c_mode_create.
        IF screen-group1 = 'AUD'.
          screen-input = 0.
        ELSE.
          screen-input = 1.
        ENDIF.

      WHEN c_mode_display.
        IF screen-group1 = 'IDN'.
          screen-input = 1.
        ELSEIF screen-group1 = 'AUD'.
          screen-input = 0.
        ELSE.
          screen-input = 0.
        ENDIF.

      WHEN c_mode_change.
        IF screen-group1 = 'IDN'.
          screen-input = 0.
        ELSEIF screen-group1 = 'AUD'.
          screen-input = 0.
        ELSE.
          screen-input = 1.
        ENDIF.
    ENDCASE.
    MODIFY SCREEN.
  ENDLOOP.
ENDMODULE.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'S200'.
  SET TITLEBAR 'T200' WITH 'Recherche demandes'.
ENDMODULE.

MODULE prepare_alv_0200 OUTPUT.
  PERFORM alv_prepare.
  PERFORM alv_display.
ENDMODULE.

MODULE status_0300 OUTPUT.
  SET PF-STATUS 'S300'.
  SET TITLEBAR 'T300' WITH 'Confirmation suppression'.
ENDMODULE.
