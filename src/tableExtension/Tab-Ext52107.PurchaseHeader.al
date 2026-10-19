tableextension 52107 "H2O Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(52100; "H2O ByPass Work Order Payment"; Boolean)
        {
            Caption = 'ByPass Work Order Payment';
            DataClassification = CustomerContent;
        }
    }
}
