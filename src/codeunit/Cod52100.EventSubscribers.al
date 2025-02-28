codeunit 52100 "H2O Event Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeCreateDimensionsFromValidateBillToCustomerNo, '', false, false)]
    local procedure "Sales Header_OnBeforeCreateDimensionsFromValidateBillToCustomerNo"(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    begin
        SalesHeader.Validate("Work Order Type Code", SalesHeader."Shortcut Dimension 2 Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnShowDocDimOnBeforeUpdateSalesLines, '', false, false)]
    local procedure "Sales Header_OnShowDocDimOnBeforeUpdateSalesLines"(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header")
    begin
        SalesHeader.Validate("Work Order Type Code", SalesHeader."Shortcut Dimension 2 Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnAfterValidateShortcutDimCode, '', false, false)]
    local procedure "Sales Header_OnAfterValidateShortcutDimCode"(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        SalesHeader.Validate("Work Order Type Code", SalesHeader."Shortcut Dimension 2 Code")
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterSalesLineInsert(var Rec: Record "Sales Line")
    var
        GeneralFunctions: Codeunit "H2O General Functions";
    begin
        GeneralFunctions.InsertRecordInTimeKeepingTable(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterSalesLineModify(var Rec: Record "Sales Line")
    var
        GeneralFunctions: Codeunit "H2O General Functions";
    begin
        GeneralFunctions.ModifyRecordInTimeKeepingTable(Rec);
    end;
}