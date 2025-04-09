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
        field(52204; "H2O PO Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            caption = 'PO Amount';
            DecimalPlaces = 0 : 5;
        }
        field(52205; "H2O Meter No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Meter #';
        }
        field(52206; "H2O Meter Read"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Meter Read';
            DecimalPlaces = 0 : 2;
        }
        field(52207; "H2O EID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'EID';
        }
        field(52208; "H2O Endpoint type"; Text[3])
        {
            DataClassification = CustomerContent;
            Caption = 'Endpoint type';
        }
        field(52209; "H2O Register Res"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Register Res';
            DecimalPlaces = 0 : 3;
        }
        field(52210; "H2O Meter Model"; Code[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Meter Model';
        }
        field(52211; "H2O Meter Size"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Meter Size';
            DecimalPlaces = 0 : 3;
        }
    }

    /* trigger OnAfterModify()
     var
         TimeKeeping: Record "H2O Time Keeping Table";
     begin
         if "Document Type" <> "Document Type"::Invoice then
             exit;
         TimeKeeping.Init();
         TimeKeeping.TransferFields(Rec);
         if not TimeKeeping.Insert() then
             TimeKeeping.Modify();
     end;*/

}
