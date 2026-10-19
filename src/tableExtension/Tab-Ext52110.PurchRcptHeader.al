tableextension 52110 "H2O Purch. Rcpt. Header" extends "Purch. Rcpt. Header"
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
