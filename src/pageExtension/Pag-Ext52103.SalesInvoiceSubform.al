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
                BlankZero = true;
            }
            field("H2O Meter #"; Rec."H2O Meter #")
            {
                ApplicationArea = all;
                ToolTip = 'Meter #';
            }
            field("H2O Meter Read"; Rec."H2O Meter Reading")
            {
                ApplicationArea = all;
                ToolTip = 'Meter Reading';
            }
            field("H2O EID"; Rec."H2O EID")
            {
                ApplicationArea = all;
                ToolTip = 'EID';
            }
            field("H2O Endpoint type"; Rec."H2O Endpoint type")
            {
                ApplicationArea = all;
                ToolTip = 'Endpoint type';
            }
            field("H2O Register Res"; Rec."H2O Register Res")
            {
                ApplicationArea = all;
                ToolTip = 'Register Res';
            }
            field("H2O Meter Model"; Rec."H2O Meter Model")
            {
                ApplicationArea = all;
                ToolTip = 'Meter Model';
            }
            field("H2O Meter Size"; Rec."H2O Meter Size")
            {
                ApplicationArea = all;
                ToolTip = 'Meter Size';
            }
        }
    }
}