pageextension 52100 "H2O Ship-to address list" extends "Ship-to address list"
{
    layout
    {
        addlast(Control1)
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
