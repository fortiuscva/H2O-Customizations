pageextension 52102 "H2O Sales Invoice" extends "Sales Invoice"
{
    layout
    {
        addafter("Bill-to Contact No.")
        {
            field("H2O Route No."; Rec."H2O Route No.")
            {
                ApplicationArea = all;
                ToolTip = 'Route No.';
            }
            field("H2O Location Stop"; Rec."H2O Location Stop")
            {
                ToolTip = 'Location Stop';
                ApplicationArea = all;
            }
        }
    }
}
