pageextension 52103 "H2O Sales Invoice Subform" extends "Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("H2O Time Worked"; Rec."H2O Time Worked")
            {
                ApplicationArea = all;
                ToolTip = 'Time worked';
                BlankZero = true;
            }
        }
    }
}