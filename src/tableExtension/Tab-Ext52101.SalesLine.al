tableextension 52101 "H2O Sales Line" extends "Sales line"
{

    trigger OnAfterModify()
    var
        TimeKeeping: Record "H2O Time Keeping Table";
    begin
        if "Document Type" <> "Document Type"::Order then
            exit;
        TimeKeeping.Init();
        TimeKeeping.TransferFields(Rec);
        if not TimeKeeping.Insert() then
            TimeKeeping.Modify();
    end;


}
