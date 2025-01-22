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
    }
}
