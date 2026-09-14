*&---------------------------------------------------------------------*
*&  Include           MZTR_PUR_REQ_TOP
*&---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* CONCEPT : Programme Module Pool
* Un Module Pool est un programme oriente ecrans Dynpro.
* Il centralise la logique PBO/PAI et les sous-programmes FORM.
* Ici, il porte l'application CRUD complete pilotee par SAP GUI.
* Erreur frequente : melanger logique ecran et logique DB sans structure.
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* CONCEPT : Includes
* Les includes decoupent un gros programme en parties lisibles.
* TOP = donnees globales, O01 = PBO, I01 = PAI, F01 = FORM.
* Cette separation facilite maintenance et apprentissage.
* Erreur frequente : declarer des donnees globales dans O01/I01.
*---------------------------------------------------------------------*

*---------------------------------------------------------------------*
* CONCEPT : Declaration TABLES
* TABLES relie la table DDIC aux ecrans et a certains traitements.
* Utilise en Module Pool classique pour interaction Dynpro.
* Ici, TABLES ztr_pur_req facilite le mapping champ-ecran.
* Erreur frequente : oublier coherence noms champs ecran/DDIC.
*---------------------------------------------------------------------*
TABLES: ztr_pur_req.

*---------------------------------------------------------------------*
* CONCEPT : Structures de travail et variables globales
* Une structure de travail porte l'etat courant de l'ecran.
* Les variables globales partagent contexte entre PBO, PAI et FORM.
* Ici, gs_req represente la demande courante en memoire.
* Erreur frequente : ne pas nettoyer ces variables lors d'un NEW/CLEAR.
*---------------------------------------------------------------------*
DATA: gs_req TYPE ztr_pur_req,
      gs_req_db TYPE ztr_pur_req.

DATA: gv_mode TYPE c LENGTH 1,
      gv_ok_code TYPE syucomm,
      gv_save_ok TYPE syucomm,
      gv_lock_ok TYPE c LENGTH 1,
      gv_delete_confirm TYPE c LENGTH 1.

CONSTANTS: c_mode_create TYPE c VALUE 'C',
           c_mode_display TYPE c VALUE 'D',
           c_mode_change TYPE c VALUE 'U'.

CONSTANTS: c_x TYPE c VALUE 'X'.

*---------------------------------------------------------------------*
* Criteres de recherche ecran 0200
*---------------------------------------------------------------------*
DATA: gv_s_request_id TYPE ztr_pur_req-request_id,
      gv_s_requester  TYPE ztr_pur_req-requester,
      gv_s_department TYPE ztr_pur_req-department,
      gv_s_date_from  TYPE ztr_pur_req-request_date,
      gv_s_date_to    TYPE ztr_pur_req-request_date,
      gv_s_status     TYPE ztr_pur_req-status,
      gv_s_amt_min    TYPE ztr_pur_req-total_amount,
      gv_s_amt_max    TYPE ztr_pur_req-total_amount.

DATA: gt_result TYPE STANDARD TABLE OF ztr_pur_req,
      gs_result TYPE ztr_pur_req.

*---------------------------------------------------------------------*
* CONCEPT : ALV
* ALV (ABAP List Viewer) affiche un tableau triable/filtrable.
* CL_GUI_ALV_GRID fonctionne dans un conteneur Dynpro.
* Ici, il affiche les resultats multicriteres en ecran 0200.
* Erreur frequente : recreer la grille a chaque PBO sans controle.
*---------------------------------------------------------------------*
DATA: go_container TYPE REF TO cl_gui_custom_container,
      go_grid      TYPE REF TO cl_gui_alv_grid,
      gt_fcat      TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo.

DATA: gt_sel_rows  TYPE lvc_t_row,
      gs_sel_row   TYPE lvc_s_row.

DATA: gv_open_req_id TYPE ztr_pur_req-request_id.

DATA: gv_alv_initialized TYPE c LENGTH 1.
