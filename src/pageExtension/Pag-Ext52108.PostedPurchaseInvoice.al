pageextension 52108 "H2O Posted Purchase Invoice" extends "Posted Purchase Invoice"
{
    layout
    {
        addlast(General)
        {
            field("H2O ByPass Work Order Payment"; Rec."H2O ByPass Work Order Payment")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Validate Work Order Payment field.', Comment = '%';
            }
        }
    }
}
