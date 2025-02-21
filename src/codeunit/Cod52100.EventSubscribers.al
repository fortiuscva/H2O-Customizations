codeunit 52100 "H2O Event Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterSalesLineInsert(var Rec: Record "Sales Line")
    var
        GeneralProcedures: Codeunit "H2O General Procedures";
    begin
        GeneralProcedures.InsertRecordInTimeKeepingTable(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterSalesLineModify(var Rec: Record "Sales Line")
    var
        GeneralProcedures: Codeunit "H2O General Procedures";
    begin
        GeneralProcedures.ModifyRecordInTimeKeepingTable(Rec);
    end;
}