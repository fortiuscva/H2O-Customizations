page 52100 "H2O Time Keeping Table"
{
    ApplicationArea = All;
    Caption = 'Time Keeping Table';
    PageType = List;
    SourceTable = "H2O Time Keeping Table";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the value of the Unit Price field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = '%';
                }
                field("Original Ship-to Code"; Rec."Original Ship-to Code")
                {
                    ToolTip = 'Specifies the value of the Original Ship-to Code field.', Comment = '%';
                }
                field("Original Document No."; Rec."Original Document No.")
                {
                    ToolTip = 'Specifies the value of the Original Document No. field.', Comment = '%';
                }
                field("Original Line No."; Rec."Original Line No.")
                {
                    ToolTip = 'Specifies the value of the Original Line No. field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("Start Time"; Rec."Start Time")
                {
                    ToolTip = 'Specifies the value of the Start Time field.', Comment = '%';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }
                field("End Time"; Rec."End Time")
                {
                    ToolTip = 'Specifies the value of the End Time field.', Comment = '%';
                }
                field("Time Worked"; Rec."Time Worked")
                {
                    ToolTip = 'Specifies the value of the Time Worked field.', Comment = '%';
                }


                field("Payroll Code Type"; Rec."Payroll Code Type")
                {
                    ApplicationArea = all;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                    ApplicationArea = All;
                }

                field("Payroll Description"; Rec."Payroll Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Entry Number"; Rec."Entry Number")
                {
                    ApplicationArea = All;
                }


            }
        }
    }
}
