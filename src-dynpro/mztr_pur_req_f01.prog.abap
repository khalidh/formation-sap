*&---------------------------------------------------------------------*
*&  Include           MZTR_PUR_REQ_F01
*&---------------------------------------------------------------------*

INITIALIZATION.
  PERFORM init_application.

*---------------------------------------------------------------------*
* CONCEPT : Sous-programmes FORM et PERFORM
* FORM encapsule une logique reutilisable.
* PERFORM execute cette logique depuis PBO/PAI.
* Ici, operations CRUD et validations sont factorisees.
* Erreur frequente : FORMs trop longs sans responsabilites claires.
*---------------------------------------------------------------------*

FORM init_application.
  PERFORM mode_display.
  CLEAR: gs_req, gs_req_db.
  gs_req-request_date = sy-datum.
ENDFORM.

FORM mode_create.
  gv_mode = c_mode_create.
ENDFORM.

FORM mode_display.
  gv_mode = c_mode_display.
ENDFORM.

FORM mode_change.
  gv_mode = c_mode_change.
ENDFORM.

FORM clear_current_request.
  CLEAR: gs_req, gs_req_db.
  gs_req-request_date = sy-datum.
  gs_req-status = 'NEW'.
  MESSAGE s001(ztr_msg).
ENDFORM.

FORM action_display.
  IF gs_req-request_id IS INITIAL.
    MESSAGE e002(ztr_msg).
  ENDIF.

  PERFORM read_request_db USING gs_req-request_id CHANGING gs_req_db.
  gs_req = gs_req_db.
  PERFORM mode_display.
  MESSAGE s003(ztr_msg).
ENDFORM.

FORM action_change.
  IF gs_req-request_id IS INITIAL.
    MESSAGE e002(ztr_msg).
  ENDIF.

  PERFORM read_request_db USING gs_req-request_id CHANGING gs_req_db.

  IF gs_req_db-status = 'CLOSED'.
    MESSAGE e010(ztr_msg).
  ENDIF.

  gs_req = gs_req_db.
  PERFORM mode_change.
  MESSAGE s004(ztr_msg).
ENDFORM.

FORM action_save.
*---------------------------------------------------------------------*
* CONCEPT : Validation de champs
* Les validations bloquent la persistance de donnees incoherentes.
* Ici, elles sont centralisees avant INSERT/UPDATE.
* Erreur frequente : valider cote ecran seulement.
*---------------------------------------------------------------------*
  PERFORM calculate_total.
  PERFORM validate_request_data.

  CASE gv_mode.
    WHEN c_mode_create.
      PERFORM create_request.
    WHEN c_mode_change.
      PERFORM update_request.
    WHEN OTHERS.
      MESSAGE i015(ztr_msg).
  ENDCASE.
ENDFORM.

FORM action_delete.
  IF gs_req-request_id IS INITIAL.
    MESSAGE e002(ztr_msg).
  ENDIF.

  PERFORM read_request_db USING gs_req-request_id CHANGING gs_req_db.

*---------------------------------------------------------------------*
* CONCEPT : Fenetre de confirmation
* Une suppression doit etre explicitement confirmee.
* Ici, ecran modal 0300 renvoie decision YES/NO.
* Erreur frequente : supprimer sans confirmation.
*---------------------------------------------------------------------*
  CLEAR gv_delete_confirm.
  CALL SCREEN 0300 STARTING AT 30 8 ENDING AT 95 16.

  IF gv_delete_confirm = c_x.
    PERFORM delete_request_logical.
  ELSE.
    MESSAGE i012(ztr_msg).
  ENDIF.
ENDFORM.

FORM validate_request_data.
*---------------------------------------------------------------------*
* CONCEPT : CHAIN / FIELD
* CHAIN/FIELD permet des validations groupees en PAI Dynpro.
* Ici, validation centralisee en FORM pour clarte CRUD.
* Erreur frequente : validations dispersees difficiles a maintenir.
*---------------------------------------------------------------------*
  IF gs_req-request_id IS INITIAL.
    MESSAGE e002(ztr_msg).
  ENDIF.

  IF gs_req-requester IS INITIAL.
    MESSAGE e005(ztr_msg).
  ENDIF.

  IF gs_req-department IS INITIAL.
    MESSAGE e006(ztr_msg).
  ENDIF.

  IF gs_req-description IS INITIAL.
    MESSAGE e007(ztr_msg).
  ENDIF.

  IF gs_req-quantity LE 0.
    MESSAGE e008(ztr_msg).
  ENDIF.

  IF gs_req-unit_price LT 0.
    MESSAGE e009(ztr_msg).
  ENDIF.

  IF gs_req-currency IS INITIAL.
    MESSAGE e011(ztr_msg).
  ENDIF.

  IF gs_req-status IS INITIAL.
    MESSAGE e013(ztr_msg).
  ENDIF.

  IF gs_req-status <> 'NEW'
     AND gs_req-status <> 'APPROVED'
     AND gs_req-status <> 'REJECTED'
     AND gs_req-status <> 'CLOSED'.
    MESSAGE e013(ztr_msg).
  ENDIF.
ENDFORM.

FORM calculate_total.
  gs_req-total_amount = gs_req-quantity * gs_req-unit_price.
ENDFORM.

FORM read_request_db USING    p_request_id TYPE ztr_pur_req-request_id
                     CHANGING ps_req       TYPE ztr_pur_req.
*---------------------------------------------------------------------*
* CONCEPT : Open SQL + SELECT SINGLE
* Open SQL assure portabilite DB cote SAP.
* SELECT SINGLE lit un enregistrement unique.
* Ici, lecture par cle pour affichage/modif/suppression.
* Erreur frequente : oublier filtre DEL_FLAG en suppression logique.
*---------------------------------------------------------------------*
  CLEAR ps_req.

  SELECT SINGLE *
    INTO ps_req
    FROM ztr_pur_req
    WHERE mandt      = sy-mandt
      AND request_id = p_request_id
      AND del_flag   = space.

*---------------------------------------------------------------------*
* CONCEPT : SY-SUBRC
* SY-SUBRC indique le resultat de la derniere instruction ABAP.
* En SQL : 0 = trouve, sinon non trouve.
* Ici, il declenche les messages d'erreur fonctionnels.
* Erreur frequente : tester SY-SUBRC trop tard.
*---------------------------------------------------------------------*
  IF sy-subrc <> 0.
    MESSAGE e016(ztr_msg) WITH p_request_id.
  ENDIF.
ENDFORM.

FORM create_request.
  DATA: ls_exist TYPE ztr_pur_req.

  SELECT SINGLE *
    INTO ls_exist
    FROM ztr_pur_req
    WHERE mandt      = sy-mandt
      AND request_id = gs_req-request_id.

  IF sy-subrc = 0.
    MESSAGE e017(ztr_msg) WITH gs_req-request_id.
  ENDIF.

  gs_req-created_by = sy-uname.
  gs_req-created_at = sy-datum.
  gs_req-changed_by = sy-uname.
  gs_req-changed_at = sy-datum.
  gs_req-del_flag   = space.

*---------------------------------------------------------------------*
* CONCEPT : INSERT
* INSERT ajoute une nouvelle ligne en base.
* Ici, utilise uniquement en mode creation.
* Erreur frequente : INSERT sans gestion doublon.
*---------------------------------------------------------------------*
  INSERT ztr_pur_req FROM gs_req.

  IF sy-subrc = 0.
*---------------------------------------------------------------------*
* CONCEPT : COMMIT WORK
* COMMIT valide la LUW en base.
* Ici, il confirme la creation reussie.
* Erreur frequente : oublier COMMIT.
*---------------------------------------------------------------------*
    COMMIT WORK.
    MESSAGE s018(ztr_msg) WITH gs_req-request_id.
    PERFORM mode_display.
  ELSE.
*---------------------------------------------------------------------*
* CONCEPT : ROLLBACK WORK
* ROLLBACK annule les changements non valides de la LUW.
* Ici, il protege coherence si INSERT echoue.
* Erreur frequente : pas de rollback apres echec DB.
*---------------------------------------------------------------------*
    ROLLBACK WORK.
    MESSAGE e019(ztr_msg).
  ENDIF.
ENDFORM.

FORM update_request.
  PERFORM lock_request USING gs_req-request_id.

  PERFORM read_request_db USING gs_req-request_id CHANGING gs_req_db.

  IF gs_req_db-status = 'CLOSED'.
    PERFORM unlock_request USING gs_req-request_id.
    MESSAGE e010(ztr_msg).
  ENDIF.

  gs_req-created_by = gs_req_db-created_by.
  gs_req-created_at = gs_req_db-created_at.
  gs_req-changed_by = sy-uname.
  gs_req-changed_at = sy-datum.
  gs_req-del_flag   = gs_req_db-del_flag.

*---------------------------------------------------------------------*
* CONCEPT : UPDATE
* UPDATE modifie une ligne existante en base.
* Ici, applique au mode modification.
* Erreur frequente : ecraser champs d'audit.
*---------------------------------------------------------------------*
  UPDATE ztr_pur_req FROM gs_req.

  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE s020(ztr_msg) WITH gs_req-request_id.
    PERFORM mode_display.
  ELSE.
    ROLLBACK WORK.
    MESSAGE e021(ztr_msg).
  ENDIF.

  PERFORM unlock_request USING gs_req-request_id.
ENDFORM.

FORM delete_request_logical.
  DATA: ls_del TYPE ztr_pur_req.

  PERFORM lock_request USING gs_req-request_id.
  PERFORM read_request_db USING gs_req-request_id CHANGING ls_del.

  ls_del-del_flag   = c_x.
  ls_del-changed_by = sy-uname.
  ls_del-changed_at = sy-datum.

  UPDATE ztr_pur_req FROM ls_del.

  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE s022(ztr_msg) WITH gs_req-request_id.
    PERFORM clear_current_request.
    PERFORM mode_display.
  ELSE.
    ROLLBACK WORK.
    MESSAGE e023(ztr_msg).
  ENDIF.

  PERFORM unlock_request USING gs_req-request_id.
ENDFORM.

FORM lock_request USING p_request_id TYPE ztr_pur_req-request_id.
*---------------------------------------------------------------------*
* CONCEPT : Objets de verrouillage (enqueue/dequeue)
* Le verrou SAP evite les modifications concurrentes.
* ENQUEUE pose un verrou logique par cle metier.
* Ici, protege UPDATE et suppression logique.
* Erreur frequente : oublier DEQUEUE.
*---------------------------------------------------------------------*
  CALL FUNCTION 'ENQUEUE_EZTR_PUR_REQ'
    EXPORTING
      mode_ztr_pur_req = 'E'
      mandt            = sy-mandt
      request_id       = p_request_id
    EXCEPTIONS
      foreign_lock     = 1
      system_failure   = 2
      OTHERS           = 3.

*---------------------------------------------------------------------*
* CONCEPT : Gestion des exceptions
* Les modules fonction peuvent lever exceptions nommees.
* Ici, conversion en message metier lisible.
* Erreur frequente : ignorer exception et continuer.
*---------------------------------------------------------------------*
  IF sy-subrc <> 0.
    MESSAGE e024(ztr_msg) WITH p_request_id.
  ENDIF.
ENDFORM.

FORM unlock_request USING p_request_id TYPE ztr_pur_req-request_id.
  CALL FUNCTION 'DEQUEUE_EZTR_PUR_REQ'
    EXPORTING
      mode_ztr_pur_req = 'E'
      mandt            = sy-mandt
      request_id       = p_request_id.
ENDFORM.

FORM clear_search_criteria.
  CLEAR: gv_s_request_id,
         gv_s_requester,
         gv_s_department,
         gv_s_date_from,
         gv_s_date_to,
         gv_s_status,
         gv_s_amt_min,
         gv_s_amt_max.
  CLEAR gt_result.
ENDFORM.

FORM search_requests.
  DATA: lt_tmp TYPE STANDARD TABLE OF ztr_pur_req,
        ls_tmp TYPE ztr_pur_req.

  CLEAR gt_result.

  SELECT *
    INTO TABLE lt_tmp
    FROM ztr_pur_req
    WHERE mandt    = sy-mandt
      AND del_flag = space.

  LOOP AT lt_tmp INTO ls_tmp.
    IF gv_s_request_id IS NOT INITIAL
       AND ls_tmp-request_id <> gv_s_request_id.
      CONTINUE.
    ENDIF.

    IF gv_s_requester IS NOT INITIAL
       AND ls_tmp-requester <> gv_s_requester.
      CONTINUE.
    ENDIF.

    IF gv_s_department IS NOT INITIAL
       AND ls_tmp-department <> gv_s_department.
      CONTINUE.
    ENDIF.

    IF gv_s_date_from IS NOT INITIAL
       AND ls_tmp-request_date < gv_s_date_from.
      CONTINUE.
    ENDIF.

    IF gv_s_date_to IS NOT INITIAL
       AND ls_tmp-request_date > gv_s_date_to.
      CONTINUE.
    ENDIF.

    IF gv_s_status IS NOT INITIAL
       AND ls_tmp-status <> gv_s_status.
      CONTINUE.
    ENDIF.

    IF gv_s_amt_min IS NOT INITIAL
       AND ls_tmp-total_amount < gv_s_amt_min.
      CONTINUE.
    ENDIF.

    IF gv_s_amt_max IS NOT INITIAL
       AND ls_tmp-total_amount > gv_s_amt_max.
      CONTINUE.
    ENDIF.

    APPEND ls_tmp TO gt_result.
  ENDLOOP.

  IF gt_result IS INITIAL.
    MESSAGE i025(ztr_msg).
  ELSE.
    MESSAGE s026(ztr_msg).
  ENDIF.
ENDFORM.

FORM alv_prepare.
  IF go_container IS INITIAL.
    CREATE OBJECT go_container
      EXPORTING
        container_name = 'CC_ALV'.

    CREATE OBJECT go_grid
      EXPORTING
        i_parent = go_container.

    PERFORM build_fieldcatalog.
    gs_layout-zebra = c_x.
    gs_layout-sel_mode = 'A'.
  ENDIF.
ENDFORM.

FORM build_fieldcatalog.
  DATA: ls_fcat TYPE lvc_s_fcat.

  CLEAR gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'REQUEST_ID'.
  ls_fcat-coltext   = 'Demande'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'REQUEST_DATE'.
  ls_fcat-coltext   = 'Date'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'REQUESTER'.
  ls_fcat-coltext   = 'Demandeur'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'DEPARTMENT'.
  ls_fcat-coltext   = 'Service'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'DESCRIPTION'.
  ls_fcat-coltext   = 'Description'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'QUANTITY'.
  ls_fcat-coltext   = 'Qte'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'UNIT'.
  ls_fcat-coltext   = 'Unite'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'UNIT_PRICE'.
  ls_fcat-coltext   = 'Prix Unit'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'CURRENCY'.
  ls_fcat-coltext   = 'Devise'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'TOTAL_AMOUNT'.
  ls_fcat-coltext   = 'Montant'.
  APPEND ls_fcat TO gt_fcat.

  CLEAR ls_fcat.
  ls_fcat-fieldname = 'STATUS'.
  ls_fcat-coltext   = 'Statut'.
  APPEND ls_fcat TO gt_fcat.
ENDFORM.

FORM alv_display.
  IF go_grid IS NOT INITIAL.
    CALL METHOD go_grid->set_table_for_first_display
      EXPORTING
        is_layout       = gs_layout
      CHANGING
        it_outtab       = gt_result
        it_fieldcatalog = gt_fcat.
  ENDIF.
ENDFORM.

FORM alv_refresh.
  IF go_grid IS INITIAL.
    RETURN.
  ENDIF.

  CALL METHOD go_grid->refresh_table_display.
ENDFORM.

FORM open_selected_from_alv.
  DATA: lt_rows TYPE lvc_t_row,
        ls_row  TYPE lvc_s_row.

  IF go_grid IS INITIAL.
    MESSAGE i025(ztr_msg).
    RETURN.
  ENDIF.

  CALL METHOD go_grid->get_selected_rows
    IMPORTING
      et_index_rows = lt_rows.

  READ TABLE lt_rows INTO ls_row INDEX 1.
  IF sy-subrc <> 0.
    MESSAGE i027(ztr_msg).
    RETURN.
  ENDIF.

  READ TABLE gt_result INTO gs_result INDEX ls_row-index.
  IF sy-subrc <> 0.
    MESSAGE i027(ztr_msg).
    RETURN.
  ENDIF.

  gs_req-request_id = gs_result-request_id.
  PERFORM read_request_db USING gs_req-request_id CHANGING gs_req_db.
  gs_req = gs_req_db.
  PERFORM mode_display.
  LEAVE TO SCREEN 0.
ENDFORM.
