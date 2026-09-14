*&---------------------------------------------------------------------*
*&  Include           MZTR_PUR_REQ_I01
*&---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* CONCEPT : PAI - Process After Input
* Le PAI est execute apres une action utilisateur.
* Il lit SY-UCOMM et declenche logique metier/navigation.
* Ici, il pilote CRUD, recherche et navigation entre ecrans.
* Erreur frequente : ne pas vider le code fonction apres traitement.
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* CONCEPT : MODULE ... INPUT
* Un MODULE INPUT est appele depuis le flow logic PAI.
* Il interprete les commandes et valide la saisie.
* Ici, user_command_xxxx centralise les actions de chaque ecran.
* Erreur frequente : dupliquer les CASE dans plusieurs modules.
*---------------------------------------------------------------------*

MODULE user_command_0100 INPUT.
*---------------------------------------------------------------------*
* CONCEPT : OK_CODE et SY-UCOMM
* SY-UCOMM contient le dernier code de fonction declenche.
* On le copie dans une variable puis on le vide.
* Cela evite une double execution involontaire au cycle suivant.
* Erreur frequente : traiter SY-UCOMM directement sans CLEAR.
*---------------------------------------------------------------------*
  gv_save_ok = sy-ucomm.
  CLEAR sy-ucomm.

  CASE gv_save_ok.
    WHEN 'NEW'.
      PERFORM mode_create.
      PERFORM clear_current_request.

    WHEN 'SEARCH'.
      CALL SCREEN 0200 STARTING AT 5 2 ENDING AT 120 25.

    WHEN 'DISPLAY'.
      PERFORM action_display.

    WHEN 'CHANGE'.
      PERFORM action_change.

    WHEN 'SAVE'.
      PERFORM action_save.

    WHEN 'DELETE'.
      PERFORM action_delete.

    WHEN 'CLEAR'.
      PERFORM clear_current_request.

    WHEN 'BACK' OR 'EXIT' OR 'CANCEL'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.

MODULE user_command_0200 INPUT.
  gv_save_ok = sy-ucomm.
  CLEAR sy-ucomm.

  CASE gv_save_ok.
    WHEN 'EXEC_SRCH'.
      PERFORM search_requests.
      PERFORM alv_refresh.

    WHEN 'RESET_SRCH'.
      PERFORM clear_search_criteria.
      PERFORM alv_refresh.

    WHEN 'OPEN_REQ'.
      PERFORM open_selected_from_alv.

    WHEN 'BACK' OR 'CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.

MODULE user_command_0300 INPUT.
  gv_save_ok = sy-ucomm.
  CLEAR sy-ucomm.

  CASE gv_save_ok.
    WHEN 'YES'.
      gv_delete_confirm = c_x.
      LEAVE TO SCREEN 0.
    WHEN 'NO' OR 'CANCEL'.
      CLEAR gv_delete_confirm.
      LEAVE TO SCREEN 0.
  ENDCASE.
ENDMODULE.
