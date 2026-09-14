REPORT ztr_pur_req_clear_demo MESSAGE-ID ztr_msg.

START-OF-SELECTION.

  DELETE FROM ztr_pur_req
    WHERE mandt = sy-mandt
      AND request_id IN ('REQ0000001', 'REQ0000002').

  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE s030(ztr_msg).
  ELSE.
    ROLLBACK WORK.
    MESSAGE i031(ztr_msg).
  ENDIF.
