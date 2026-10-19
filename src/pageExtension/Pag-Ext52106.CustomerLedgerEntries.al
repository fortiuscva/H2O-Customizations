pageextension 52106 "H2O Customer Ledger Entries" extends "Customer Ledger Entries"
{
    layout
    {
        addafter("Document No.")
        {
            field("H2O Purchase Order No."; Rec."H2O Purchase Order No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Purchase Order No. field.', Comment = '%';
            }
        }
    }
}
