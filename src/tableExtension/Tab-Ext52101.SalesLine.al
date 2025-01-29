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
        field(52202; "H2O Vendor No."; code[20])
        {
            DataClassification = ToBeClassified;
            caption = 'Vendor No.';
            Tablerelation = Vendor;
        }
        field(52203; "H2O Vendor PO"; code[35])
        {
            DataClassification = ToBeClassified;
            caption = 'Vendor PO';
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
