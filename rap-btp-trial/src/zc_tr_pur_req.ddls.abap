@EndUserText.label: 'Purchase Request Consumption View'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI.headerInfo: {
  typeName: 'Purchase Request',
  typeNamePlural: 'Purchase Requests',
  title: { value: 'RequestID' },
  description: { value: 'Department' }
}
@UI.presentationVariant: [{ sortOrder: [{ by: 'RequestDate', direction: #DESC }] }]
define view entity ZC_TR_PUR_REQ
  as projection on ZI_TR_PUR_REQ
{
  key RequestID,

  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  RequestID,

  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  RequestDate,

  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  Requester,

  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  Department,

  @UI.identification: [{ position: 50 }]
  Description,

  @UI.lineItem: [{ position: 50 }]
  Quantity,

  Unit,

  @UI.lineItem: [{ position: 60 }]
  UnitPrice,

  Currency,

  @UI.lineItem: [{ position: 70 }]
  TotalAmount,

  @UI.lineItem: [{ position: 80 }]
  Status,

  CreatedBy,
  CreatedAt,
  ChangedBy,
  ChangedAt,
  DelFlag
}
