pageextension 52100 "H2O Ship-to address list" extends "Ship-to address list"
{
    layout
    {
        addlast(Control1)
        {
<<<<<<< HEAD
            field("H2O Temporary Property No."; Rec."H2O Temporary Property No.")
            {
                ApplicationArea = all;
                ToolTip = 'Temporary Property No.';
            }
=======
>>>>>>> 3de5270 (H20-004 - Route number visibility)
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
