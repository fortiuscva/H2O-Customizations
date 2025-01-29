tableextension 52101 "H2O Sales Line" extends "Sales line"
{
    fields
    {
        field(52201; "H2O Time Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
            caption = 'Time Worked';
        }
    }

    trigger OnAfterModify()
    var
        TimeKeeping: Record "H2O Time Keeping Table";
    begin
        if "Document Type" <> "Document Type"::Invoice then
            exit;
        TimeKeeping.Init();
        TimeKeeping.TransferFields(Rec);
        if not TimeKeeping.Insert() then
            TimeKeeping.Modify();
    end;

}
