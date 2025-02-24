tableextension 52102 "H2O Ship to Address" extends "Ship-to Address"
{
    fields
    {
        field(52100; "H2O Pending Property"; Boolean)
        {
            Caption = 'Pending Property';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SalesandRecieveSetup: Record "Sales & Receivables Setup";
                NoSeries: Codeunit "No. Series";
            begin
                if (Rec."H2O Pending Property" = true) then begin
                    Rec.TestField("H2O Temporary Property No.", '');
                    SalesandRecieveSetup.get;
                    SalesandRecieveSetup.TestField("H2O Temporary Property Nos.");
                    Rec.Code := NoSeries.GetNextNo(SalesandRecieveSetup."H2O Temporary Property Nos.", WorkDate());
                    //if not Rec.Insert(true) then
                    //Rec.Rename(Rec.code)
                end else
                    Rec."H2O Temporary Property No." := Rec.Code;
            end;
        }
        field(52101; "H2O Temporary Property No."; Code[10])
        {
            Caption = 'Temporary Property No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
    }
}
