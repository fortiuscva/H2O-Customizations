pageextension 52104 "H2O Sales_and_Receivables Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("H2O Temporary Property Nos."; Rec."H2O Temporary Property Nos.")
            {
                ApplicationArea = all;
            }
        }
    }
}
