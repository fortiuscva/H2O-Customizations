tableextension 52104 "H2O Cust. Ledger Entry" extends "Cust. Ledger Entry"
{
    fields
    {
        field(52100; "H2O Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            DataClassification = CustomerContent;
        }
    }
}
