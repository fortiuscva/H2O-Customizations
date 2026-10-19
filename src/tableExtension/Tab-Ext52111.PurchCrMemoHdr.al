tableextension 52111 "H2O Purch. Cr. Memo Hdr." extends "Purch. Cr. Memo Hdr."
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
