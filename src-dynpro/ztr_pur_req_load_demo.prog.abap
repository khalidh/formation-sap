REPORT ztr_pur_req_load_demo MESSAGE-ID ztr_msg.

DATA: ls_req TYPE ztr_pur_req,
      lt_req TYPE STANDARD TABLE OF ztr_pur_req.

START-OF-SELECTION.

  CLEAR lt_req.

  CLEAR ls_req.
  ls_req-mandt        = sy-mandt.
  ls_req-request_id   = 'REQ0000001'.
  ls_req-request_date = sy-datum - 10.
  ls_req-requester    = sy-uname.
  ls_req-department   = 'IT'.
  ls_req-description  = 'Ordinateur portable'.
  ls_req-quantity     = '1.000'.
  ls_req-unit         = 'PC'.
  ls_req-unit_price   = '1200.00'.
  ls_req-currency     = 'EUR'.
  ls_req-total_amount = ls_req-quantity * ls_req-unit_price.
  ls_req-status       = 'NEW'.
  ls_req-created_by   = sy-uname.
  ls_req-created_at   = sy-datum - 10.
  ls_req-changed_by   = sy-uname.
  ls_req-changed_at   = sy-datum - 10.
  ls_req-del_flag     = space.
  APPEND ls_req TO lt_req.

  CLEAR ls_req.
  ls_req-mandt        = sy-mandt.
  ls_req-request_id   = 'REQ0000002'.
  ls_req-request_date = sy-datum - 5.
  ls_req-requester    = sy-uname.
  ls_req-department   = 'FINANCE'.
  ls_req-description  = 'Licences bureautiques'.
  ls_req-quantity     = '10.000'.
  ls_req-unit         = 'EA'.
  ls_req-unit_price   = '85.00'.
  ls_req-currency     = 'EUR'.
  ls_req-total_amount = ls_req-quantity * ls_req-unit_price.
  ls_req-status       = 'APPROVED'.
  ls_req-created_by   = sy-uname.
  ls_req-created_at   = sy-datum - 5.
  ls_req-changed_by   = sy-uname.
  ls_req-changed_at   = sy-datum - 5.
  ls_req-del_flag     = space.
  APPEND ls_req TO lt_req.

  MODIFY ztr_pur_req FROM TABLE lt_req.

  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE s028(ztr_msg).
  ELSE.
    ROLLBACK WORK.
    MESSAGE e029(ztr_msg).
  ENDIF.
