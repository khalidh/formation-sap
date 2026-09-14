projection;

define behavior for ZC_TR_PUR_REQ alias PurchaseRequest
{
  use create;
  use update;
  use delete;

  use determination calculateTotal;
  use determination setAudit;
  use validation validateMandatory;
  use validation validateStatus;
  use validation validateClosedNotEditable;
}
