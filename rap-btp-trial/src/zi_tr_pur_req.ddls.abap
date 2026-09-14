@EndUserText.label: 'Purchase Request Interface View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TR_PUR_REQ
  as select from ztr_pur_req_rap
{
  key request_id   as RequestID,
      request_date as RequestDate,
      requester as Requester,
      department as Department,
      description as Description,
      quantity as Quantity,
      unit as Unit,
      unit_price as UnitPrice,
      currency as Currency,
      total_amount as TotalAmount,
      status as Status,
      created_by as CreatedBy,
      created_at as CreatedAt,
      changed_by as ChangedBy,
      changed_at as ChangedAt,
      del_flag as DelFlag
}
