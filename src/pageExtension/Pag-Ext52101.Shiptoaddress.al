pageextension 52101 "H2O Ship-to address" extends "Ship-to address"
{
    layout
    {
<<<<<<< HEAD
        addbefore(Code)
        {
            field("H2O Pending Property"; Rec."H2O Pending Property")
            {
                ApplicationArea = all;
                ToolTip = 'Pending Property';
            }
        }
=======
>>>>>>> 3de5270 (H20-004 - Route number visibility)
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
<<<<<<< HEAD
        addlast(General)
        {
            field("H2O Temporary Property No."; Rec."H2O Temporary Property No.")
            {
                ApplicationArea = all;
                ToolTip = 'Temporary Property No.';
            }
        }
=======
>>>>>>> 3de5270 (H20-004 - Route number visibility)
    }
}
