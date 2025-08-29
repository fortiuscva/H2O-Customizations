tableextension 52102 "H2O Ship to Address" extends "Ship-to Address"
{
    fields
    {
        field(52100; "H2O Pending Property"; Boolean)
        {
            Caption = 'Pending Property';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Rec.TestField(Code, '');
                Rec.Validate(Code, '');
            end;
        }
        modify(Code)
        {
            trigger OnAfterValidate()
            begin
                if Code <> '' then
                    if "H2O Pending Property" then
                        Validate("H2O Pending Property", false);
            end;
        }
        field(52101; "H2O Temporary Property No."; Code[10])
        {
            Caption = 'Temporary Property No.';
            Editable = false;
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                SalesandRecieveSetup: Record "Sales & Receivables Setup";
                NoSeries: Codeunit "No. Series";
            begin
                if "H2O Temporary Property No." <> xRec."H2O Temporary Property No." then begin
                    SalesandRecieveSetup.get;
                    NoSeries.TestManual(SalesandRecieveSetup."H2O Temporary Property Nos.");
                    "H2O No. Series" := '';
                end;
            end;
        }
        field(11; "H2O No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
        }
    }
    trigger OnBeforeInsert()
    var
        SalesandRecieveSetup: Record "Sales & Receivables Setup";
        NoSeries: Codeunit "No. Series";
    begin
        SalesandRecieveSetup.get;
        if (Rec."H2O Pending Property" = true) then begin
            SalesandRecieveSetup.TestField("H2O Temporary Property Nos.");
            "H2O No. Series" := SalesandRecieveSetup."H2O Temporary Property Nos.";
            if NoSeries.AreRelated("H2O No. Series", xRec."H2O No. Series") then
                "H2O No. Series" := xRec."H2O No. Series";
            "H2O Temporary Property No." := NoSeries.GetNextNo("H2O No. Series", WorkDate());
            Rec.Validate(Code, Rec."H2O Temporary Property No.");
            Rec.Insert();
        end;
    end;

    trigger OnAfterInsert()
    begin
        if Rec."H2O Pending Property" = false then
            Rec.Validate("H2O Temporary Property No.", Code);
    end;
}
