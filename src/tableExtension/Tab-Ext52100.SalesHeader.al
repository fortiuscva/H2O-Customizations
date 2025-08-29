tableextension 52100 "H2O Sales Header" extends "sales header"
{
    fields
    {
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate()
            begin
                Rec.Validate("Work Order Type Code", Rec."Shortcut Dimension 2 Code");
            end;
        }
    }
}
