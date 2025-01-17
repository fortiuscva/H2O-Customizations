pageextension 52101 "H2O Ship-to address" extends "Ship-to address"
{
    layout
    {
        addafter("Blocked")
        {
            field("H2O Route No."; Rec."Route No.")
            {
                ApplicationArea = all;
                ToolTip = 'Route No.';
            }
            field("H2O Location Stop"; Rec."Location Stop")
            {
                ToolTip = 'Location Stop';
                ApplicationArea = all;
            }
        }
    }
}
