pageextension 52103 "H2O Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("H2O Vendor No."; Rec."H2O Vendor No.")
            {
                ApplicationArea = all;
                ToolTip = 'Vendor No.';
            }
            field("H2O Vendor PO"; Rec."H2O Vendor PO")
            {
                ApplicationArea = all;
                ToolTip = 'Vendor PO';
            }
            field("H2O PO Amount"; Rec."H2O PO Amount")
            {
                ApplicationArea = all;
                ToolTip = 'PO Amount';
                BlankZero = true;
            }
            field("H2O Time Worked"; Rec."H2O Time Worked")
            {
                ApplicationArea = all;
                ToolTip = 'Time worked';
            }
        }
    }
}