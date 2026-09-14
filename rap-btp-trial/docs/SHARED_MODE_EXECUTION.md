# Shared mode execution guidance

If your SAP BTP trial tenant exposes SAP BTP ABAP Environment in shared mode:

1. Create the repository package in ADT.
2. Create the persistence table `ZTR_PUR_REQ_RAP`.
3. Create the interface and consumption views.
4. Create the managed behavior definition and projection behavior.
5. Create the behavior pool class.
6. Create the service definition and service binding.
7. Generate the Fiori elements app from the bound service.
8. Test create, update, delete, search, and status rules.

The simplest execution path for the training app uses `RequestID` as the root key and keeps the same business rules as the Dynpro app.
