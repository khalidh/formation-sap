CLASS zbp_i_tr_pur_req DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zi_tr_pur_req.
ENDCLASS.

CLASS zbp_i_tr_pur_req IMPLEMENTATION.
ENDCLASS.

CLASS lhc_PurchaseRequest DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS calculateTotal FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurchaseRequest~calculateTotal.

    METHODS setAudit FOR DETERMINE ON MODIFY
      IMPORTING keys FOR PurchaseRequest~setAudit.

    METHODS validateMandatory FOR VALIDATE ON SAVE
      IMPORTING keys FOR PurchaseRequest~validateMandatory.

    METHODS validateStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR PurchaseRequest~validateStatus.

    METHODS validateClosedNotEditable FOR VALIDATE ON SAVE
      IMPORTING keys FOR PurchaseRequest~validateClosedNotEditable.
ENDCLASS.

CLASS lhc_PurchaseRequest IMPLEMENTATION.
  METHOD calculateTotal.
    READ ENTITIES OF zi_tr_pur_req IN LOCAL MODE
      ENTITY PurchaseRequest
      FIELDS ( RequestID Quantity UnitPrice TotalAmount )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    MODIFY ENTITIES OF zi_tr_pur_req IN LOCAL MODE
      ENTITY PurchaseRequest
      UPDATE FIELDS ( TotalAmount )
      WITH VALUE #( FOR ls_request IN lt_requests
                    ( RequestID    = ls_request-RequestID
                      TotalAmount  = ls_request-Quantity * ls_request-UnitPrice ) )
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).
  ENDMETHOD.

  METHOD setAudit.
    READ ENTITIES OF zi_tr_pur_req IN LOCAL MODE
      ENTITY PurchaseRequest
      FIELDS ( RequestID CreatedBy CreatedAt ChangedBy ChangedAt )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    MODIFY ENTITIES OF zi_tr_pur_req IN LOCAL MODE
      ENTITY PurchaseRequest
      UPDATE FIELDS ( CreatedBy CreatedAt ChangedBy ChangedAt )
      WITH VALUE #( FOR ls_request IN lt_requests
                    ( RequestID = ls_request-RequestID
                      CreatedBy = COND #( WHEN ls_request-CreatedBy IS INITIAL THEN cl_abap_context_info=>get_user_technical_name( ) ELSE ls_request-CreatedBy )
                      CreatedAt = COND #( WHEN ls_request-CreatedAt IS INITIAL THEN cl_abap_context_info=>get_system_date( ) ELSE ls_request-CreatedAt )
                      ChangedBy = cl_abap_context_info=>get_user_technical_name( )
                      ChangedAt = cl_abap_context_info=>get_system_date( ) ) )
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).
  ENDMETHOD.

  METHOD validateMandatory.
    READ ENTITIES OF zi_tr_pur_req IN LOCAL MODE
      ENTITY PurchaseRequest
      FIELDS ( RequestID RequestDate Requester Department Description Quantity Unit UnitPrice Currency Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    LOOP AT lt_requests INTO DATA(ls_request).
      IF ls_request-RequestID IS INITIAL
      OR ls_request-RequestDate IS INITIAL
      OR ls_request-Requester IS INITIAL
      OR ls_request-Department IS INITIAL
      OR ls_request-Description IS INITIAL
      OR ls_request-Quantity IS INITIAL
      OR ls_request-Unit IS INITIAL
      OR ls_request-UnitPrice IS INITIAL
      OR ls_request-Currency IS INITIAL
      OR ls_request-Status IS INITIAL.
        APPEND VALUE #( %key = ls_request-%key ) TO failed-PurchaseRequest.
        APPEND VALUE #( %key = ls_request-%key
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text = 'Mandatory field missing' ) ) TO reported-PurchaseRequest.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateStatus.
    READ ENTITIES OF zi_tr_pur_req IN LOCAL MODE
      ENTITY PurchaseRequest
      FIELDS ( RequestID Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    LOOP AT lt_requests INTO DATA(ls_request).
      IF ls_request-Status <> 'NEW'
      AND ls_request-Status <> 'APPROVED'
      AND ls_request-Status <> 'REJECTED'
      AND ls_request-Status <> 'CLOSED'.
        APPEND VALUE #( %key = ls_request-%key ) TO failed-PurchaseRequest.
        APPEND VALUE #( %key = ls_request-%key
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text = 'Invalid status' ) ) TO reported-PurchaseRequest.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateClosedNotEditable.
    READ ENTITIES OF zi_tr_pur_req IN LOCAL MODE
      ENTITY PurchaseRequest
      FIELDS ( RequestID Status )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    LOOP AT lt_requests INTO DATA(ls_request).
      IF ls_request-Status = 'CLOSED'.
        APPEND VALUE #( %key = ls_request-%key ) TO failed-PurchaseRequest.
        APPEND VALUE #( %key = ls_request-%key
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text = 'Closed request cannot be changed' ) ) TO reported-PurchaseRequest.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
