managed implementation in class ZBP_I_TR_PUR_REQ unique;
strict ( 2 );

define behavior for ZI_TR_PUR_REQ alias PurchaseRequest
persistent table ztr_pur_req_rap
lock master
authorization master ( instance )
{
  create;
  update;
  delete;

  field ( readonly ) CreatedBy, CreatedAt, ChangedBy, ChangedAt, TotalAmount, DelFlag;
  field ( mandatory ) RequestID, RequestDate, Requester, Department, Description, Quantity, Unit, UnitPrice, Currency, Status;

  determination calculateTotal on modify { field Quantity; field UnitPrice; }
  determination setAudit on modify { create; update; }

  validation validateMandatory on save { field RequestID; field Requester; field Department; field Description; field Quantity; field UnitPrice; field Currency; field Status; }
  validation validateStatus on save { field Status; }
  validation validateClosedNotEditable on save { update; }
}
