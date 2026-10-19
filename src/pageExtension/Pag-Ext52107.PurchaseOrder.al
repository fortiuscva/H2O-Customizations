pageextension 52107 "H2O Purchase Order" extends "Purchase Order"
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
